extends CharacterBody2D

@onready var sprite_2d = $Sprite2D

const SPEED = 500
const STEERING_ANGLE = 15
const WHEEL_BASE = 50

var steer_direction = 0.0

func _physics_process(delta):
	get_input()
	apply_physics(delta)
	move_and_slide()
	
func get_input():
	var direction = Input.get_axis("move_left", "move_right")
	
	steer_direction = lerp(steer_direction, direction * deg_to_rad(STEERING_ANGLE), 0.4)
	sprite_2d.scale.x = lerp(sprite_2d.scale.x, 1 - abs(direction / 5), 0.05)

func apply_physics(delta):
	velocity = Vector2(SPEED * cos(rotation), SPEED * sin(rotation))
	rotation += steer_direction * SPEED * delta / WHEEL_BASE
