extends Node

var player_fuel: int = 100:
	set(value):player_fuel = clamp(value, 0, 100)

var difficulty: int = 2

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass
