extends Label

@onready var player = $"../../../World/Entity/Player"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false
	player.player_death.connect(_on_player_death)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_player_death():
	visible = true
	
