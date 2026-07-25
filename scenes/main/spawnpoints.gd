extends Node2D

@onready var enemy: PackedScene = preload("res://scenes/entities/enemy/enemy.tscn")
@onready var timer: Timer = $Spawntimer
@onready var entity: Node2D = $"../Entity"

var spawnpoints : Array

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawnpoints = get_children()
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_spawntimer_timeout() -> void:
	for i in GameStats.difficulty:
		if randi_range(0,4)>1:
			var spawn_location:Vector2 = spawnpoints[randi_range(0,3)].global_position
			var new_enemy = enemy.instantiate()
			new_enemy.global_position = Vector2(spawn_location.x+randi_range(-250,250), spawn_location.y+randi_range(-250,250))
			entity.add_child(new_enemy)
	
	
	pass # Replace with function body.
