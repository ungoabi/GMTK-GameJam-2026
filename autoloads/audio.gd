extends Node


enum Bus {MASTER, MUSIC, SFX, UI}

const bus_map: Dictionary[Bus, StringName] = {
	Bus.MASTER: &"Master",
	Bus.MUSIC: &"Music",
	Bus.SFX: &"SFX",
	Bus.UI: &"UI"
}
const default_pitch_variance: float = 0.1

var music_player: AudioStreamPlayer

var playlist: Array[AudioStream] = [
	preload("res://assets/audio/music/Countdown to the End.mp3"),
	preload("res://assets/audio/music/Countdown Boss Intro.mp3"),
	preload("res://assets/audio/music/Countdown Boss Fight.mp3")
]

func _ready() -> void:
	music_player = AudioStreamPlayer.new()
	music_player.bus = bus_map[Bus.MUSIC]
	add_child(music_player)
	_start_bgm()
	music_player.volume_db-=5


func play_music(stream: AudioStream) -> void:
	if not stream:
		return
	
	if music_player.playing and music_player.stream == stream:
		return
	
	music_player.stream = stream
	music_player.play()


func stop_music() -> void:
	music_player.stop()

func _start_bgm():
	play_music(playlist[0])
	music_player.finished.connect(_on_bgm_finished)

func play_sfx(stream: AudioStream, pitch_variance: float = default_pitch_variance) -> void:
	_play_one_shot(stream, Bus.SFX, Node.PROCESS_MODE_INHERIT, pitch_variance)


func play_ui_sound(stream: AudioStream) -> void:
	_play_one_shot(stream, Bus.UI, Node.PROCESS_MODE_ALWAYS, 0)


func _play_one_shot(stream: AudioStream, bus: Bus, mode: Node.ProcessMode, pitch_variance: float) -> void:
	if not stream:
		return
	
	var player: AudioStreamPlayer = _create_player(stream, bus)
	player.process_mode = mode
	player.pitch_scale = _pitch_variance(pitch_variance)
	add_child(player)
	player.volume_db-=17
	player.play()


func _create_player(stream: AudioStream, bus: Bus) -> AudioStreamPlayer:
	var player: AudioStreamPlayer = AudioStreamPlayer.new()
	player.bus = bus_map[bus]
	player.stream = stream
	player.finished.connect(player.queue_free)
	return player


func _pitch_variance(variance: float) -> float:
	if variance == 0:
		return 1
	return max(0.01, randf_range(1-variance, 1+variance))
	
func _on_bgm_finished():
	if music_player.stream == playlist[0]:
		play_music(playlist[1])
	else:
		play_music(playlist[2])
		
func reset():
	_start_bgm()
