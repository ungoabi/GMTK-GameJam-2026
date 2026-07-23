class_name Projectile
extends Area2D


@export var speed: float = 100
@export var travel_range: float = 1000

@onready var direction: Vector2 = Vector2.ZERO
@onready var traveled_distance: float = 0
