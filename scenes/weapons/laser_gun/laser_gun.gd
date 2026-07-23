extends Weapon


func _spawn_projectile(marker: Marker2D) -> void:
	var offset: float = _random_offset(0.1)
	var new_projectile: Projectile = projectile_scene.instantiate() as Projectile
	new_projectile.global_position = marker.global_position
	new_projectile.global_rotation = marker.global_rotation + offset
	projectile_container.add_child(new_projectile)
	new_projectile.direction = Vector2.RIGHT.rotated(marker.global_rotation + offset)
	
