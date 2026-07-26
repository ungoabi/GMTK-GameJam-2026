extends Control

@onready var progress_bar: ProgressBar = $ProgressBar
@onready var player: Node2D = $"../../../World/Entity/Player"
@onready var game_timer: Label = $"../Time_Label"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.player_death.connect(_on_player_death_label)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	progress_bar.value = GameStats.player_fuel

func _on_player_death_label():
	visible = false
	game_timer.visible=false
	
