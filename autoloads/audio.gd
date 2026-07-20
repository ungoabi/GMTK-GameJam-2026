extends Node


enum Bus {MASTER, MUSIC, SFX, UI}

const bus_map: Dictionary[Bus, StringName] = {
	Bus.MASTER: &"Master",
	Bus.MUSIC: &"Music",
	Bus.SFX: &"SFX",
	Bus.UI: &"UI"
}

var current_music_player: AudioStreamPlayer


func play_music(stream: AudioStream) -> void:
	if not stream: return
	
	if current_music_player:
		current_music_player.stop()
		current_music_player.queue_free()
	
	var player = _create_player(stream, Bus.MUSIC)
	current_music_player = player
	add_child(player)
	player.play()


func stop_music() -> void:
	if current_music_player:
		current_music_player.stop()
		current_music_player.queue_free()
		current_music_player = null


func play_sfx(stream: AudioStream) -> void:
	_play_one_shot(stream, Bus.SFX, Node.PROCESS_MODE_INHERIT)


func play_ui_sound(stream: AudioStream) -> void:
	_play_one_shot(stream, Bus.UI, Node.PROCESS_MODE_ALWAYS)


func _play_one_shot(stream: AudioStream, bus: Bus, mode: Node.ProcessMode) -> void:
	if not stream:
		return
	
	var player := _create_player(stream, bus)
	player.process_mode = mode
	player.finished.connect(player.queue_free)
	add_child(player)
	player.play()


func _create_player(stream: AudioStream, bus: Bus) -> AudioStreamPlayer:
	var player := AudioStreamPlayer.new()
	player.stream = stream
	player.bus = bus_map[bus]
	return player
