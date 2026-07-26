extends Weapon
class_name LaserGun

@onready var player = $"../.."

func _ready() -> void:
	add_to_group("laser")
	weapon_level=1
	

func _spawn_projectile(marker: Marker2D) -> void:
	var offset: float = _random_offset(0.1)
	var new_projectile: Projectile = projectile_scene.instantiate() as Projectile
	new_projectile.global_position = marker.global_position
	new_projectile.global_rotation = marker.global_rotation + offset
	projectile_container.add_child(new_projectile)
	new_projectile.direction = Vector2.RIGHT.rotated(marker.global_rotation + offset)
	
func apply_upgrade():
	#I don't know why I have to do this. fire_cooldown starts at 0.5 for some reason even though it's set to 1 in the editor
	fire_cooldown = 1
	var new_fire_cooldown = fire_cooldown - (weapon_level * 0.15)
	fire_cooldown_timer.wait_time = new_fire_cooldown
	GameStats.difficulty+=1
	player.level = weapon_level
	print("upgrade applied. cooldown is"+str(fire_cooldown_timer.wait_time)+" World diff:"+str(GameStats.difficulty))
