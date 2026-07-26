extends Node

var player_fuel: int = 100:
	set(value):player_fuel = clamp(value, 0, 100)

var difficulty: int = 2

signal petunia 

func _ready() -> void:
	pass

#func _process(delta: float) -> void:
	#if player_fuel<1:
		#reset()
		
func reset():
	Audio.stop_music()
	Audio._start_bgm()
	player_fuel = 100
	difficulty = 2
	get_tree().reload_current_scene()
