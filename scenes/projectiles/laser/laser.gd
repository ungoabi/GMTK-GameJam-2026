extends Projectile


func _physics_process(delta: float) -> void:
	_move(delta)
	
	if traveled_distance >= travel_range:
		queue_free()

func _move(delta: float) -> void:
	var distance: float = speed * delta
	position += direction * distance
	traveled_distance += distance
