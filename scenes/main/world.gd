extends Node2D

@onready var game_timer: Timer = $Game_Timer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_game_timer_timeout() -> void:
	GameStats.petunia.emit()
