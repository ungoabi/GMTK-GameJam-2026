extends Label

@onready var petunia = $"../../../World/Entity/Petunia"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false
	petunia.petunia_death.connect(_on_petunia_death2)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_petunia_death2():
	visible = true
