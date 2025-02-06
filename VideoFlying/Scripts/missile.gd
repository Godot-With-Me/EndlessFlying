extends CharacterBody2D

@onready var airplane = $"../%Airplane"

var speed
var close_speed
var steering_angle

var dead = false

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	speed = randf_range(600.0, 800.0)
	close_speed = randf_range(450.0, 590.0)
	steering_angle = randf_range(0.25, 3.0)
	$death.wait_time = randf_range(1.0, 5.0)

func _physics_process(delta):
	if !dead: apply_physics(delta)
	move_and_slide()
	
func apply_physics(delta):
	var seperation_force = calculate_seperation_force()
	var direction = (airplane.global_position - global_position).normalized()
	var combined_direction = (direction + seperation_force).normalized()
	
	var target_rotation = combined_direction.angle()
	
	rotation = lerp_angle(rotation, target_rotation, steering_angle * delta)
	
	if global_position.distance_to(airplane.global_position) < 500:
		speed = lerp(speed, close_speed, 0.05)
		
	velocity = Vector2.from_angle(rotation) * speed

func _on_area_2d_body_entered(body):
	if !dead && body != self:
		dead = true
		body.explosion()
		explosion()

func explosion():
	dead = true
	$CollisionShape2D.call_deferred("set_disabled", true)
	$Explosion.emitting = true
	$Sprite2D.visible = false
	await get_tree().create_timer(1.1).timeout
	queue_free()

func death_timer_start():
	$death.start()
	
const SEPARATION_DISTANCE = 100.0
const SEPARATION_STRENGTH = 20.0

func calculate_seperation_force():
	var force = Vector2.ZERO
	var missile_group = get_tree().get_nodes_in_group("missile")
	
	for missile in missile_group:
		if missile == self:
			continue
			
		var distance = global_position.distance_to(missile.global_position)
		
		if distance < SEPARATION_DISTANCE:
			force += (global_position - missile.global_position).normalized() / distance
			
	return force * SEPARATION_STRENGTH
