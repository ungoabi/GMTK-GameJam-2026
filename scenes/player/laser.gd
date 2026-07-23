extends Area2D

var travelled_distance=0

@export var speed:int = 100
@export var range:int = 1000

func _physics_process(delta: float):
	
	#Telling the laser to move and rotate appropriately
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * speed * delta
	
	travelled_distance += speed * delta
	
	#Destroys the laser when it travels outside its range
	if travelled_distance > range:
		queue_free()
		#print("laser destroyed due to range")

#Detecting collisions and telling objects with the "take_damage" function to take damage when a collision occurs
#This function is broken right now, should be checking for characterbody2d possibly?
func _on_area_entered(area: Node2D):
	
	if area.has_method("take_damage"):
		area.take_damage(5)
	
	queue_free()
	print("laser destroyed in collision")
	
