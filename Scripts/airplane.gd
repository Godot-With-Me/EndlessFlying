extends CharacterBody2D

@onready var sprite_2d = $Sprite2D
@onready var canvas_layer = $"../CanvasLayer"

const SPEED = 500
const STEERING_ANGLE = 15
const WHEEL_BASE = 50

var steer_direction = 0.0

func _ready():
	$Sprite2D.texture = load("res://Assets/airplane"+ str(Global.save_dict["curr_plane"] + 1) + ".png")
	#Change the colliders as well
	
	match Global.save_dict["curr_trail"]:
		1:
			$Line2D.default_color = Color(0, 0.68, 0.671)
			$Line2D2.default_color = Color(0, 0.68, 0.671)
		2:
			$Line2D.default_color = Color(0.791, 0, 0.403)
			$Line2D2.default_color = Color(0.791, 0, 0.403)
		3:
			$Line2D.default_color = Color(0.167, 0.336, 1)
			$Line2D2.default_color = Color(0.167, 0.336, 1)

func _physics_process(delta):
	if !Global.dead:
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

func explosion():
	if !Global.dead:
		if Global.save_dict["max_score"] < Global.score:
			Global.save_dict["max_score"] = Global.score
		
		Global.save_dict["money"] += Global.score
		Global.dead = true
		Engine.time_scale = 0.1
		$Explosion.emitting = true
		$Sprite2D.visible = false
		$Line2D.visible = false
		$Line2D2.visible = false
		canvas_layer.is_dead()
