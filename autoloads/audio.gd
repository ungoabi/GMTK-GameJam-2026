extends Node


enum Bus {MASTER, MUSIC, SFX, UI}

const bus_map: Dictionary[Bus, String] = {Bus.MASTER: "Master", Bus.MUSIC: "Music", Bus.SFX: "SFX", Bus.UI: "UI"}

var current_music_player: AudioStreamPlayer


func play_music(stream: AudioStream) -> void:
	if not stream: return
	
	if current_music_player:
		current_music_player.stop()
		current_music_player.queue_free()
	
	var player = _create_player(stream, Bus.MUSIC)
	_play_audio(player)
	current_music_player = player


func stop_music() -> void:
	if current_music_player:
		current_music_player.queue_free()
		current_music_player = null


func play_sfx(stream: AudioStream) -> void:
	if not stream: return
	
	var player = _create_player(stream, Bus.SFX)
	_play_audio(player)
	player.finished.connect(player.queue_free)


func play_ui_sound(stream: AudioStream) -> void:
	if not stream: return
	
	var player = _create_player(stream, Bus.UI)
	player.process_mode = Node.PROCESS_MODE_ALWAYS
	_play_audio(player)
	player.finished.connect(player.queue_free)


func _create_player(stream: AudioStream, bus: Bus) -> AudioStreamPlayer:
	var player = AudioStreamPlayer.new()
	player.stream = stream
	player.bus = bus_map.get(bus)
	return player


func _play_audio(player: AudioStreamPlayer) -> void:
	add_child(player)
	player.play()
