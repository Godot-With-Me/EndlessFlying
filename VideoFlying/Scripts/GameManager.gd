extends Node2D

const OBJECTIVE = preload("res://Scenes/objective.tscn")

@onready var airplane = %Airplane

@onready var ground = $ParallaxBackground/Ground
@onready var sprite_ground = $ParallaxBackground/Ground/Sprite2D

@onready var clouds = $ParallaxBackground/Clouds
@onready var color_rect_clouds = $ParallaxBackground/Clouds/ColorRect

var score = 0

var temp

func _ready():
	spawn_new_objective()

func _process(_delta):
	print(str(airplane.global_position) + " " + str(temp.global_position))
	var screen_max_size = max(get_viewport().get_visible_rect().size.x, get_viewport().get_visible_rect().size.y)
	
	ground.motion_mirroring = Vector2(screen_max_size, screen_max_size)
	sprite_ground.scale = Vector2(screen_max_size / 16, screen_max_size / 16)
	sprite_ground.position = Vector2(screen_max_size / 2, screen_max_size / 2)
	
	clouds.motion_mirroring = Vector2(screen_max_size, screen_max_size)
	color_rect_clouds.size = Vector2(screen_max_size, screen_max_size)

func spawn_new_objective():
	var random_direction = randf() * TAU
	
	var random_distance = randf_range(1000.0, 4000.0)
	
	var offset = Vector2.from_angle(random_direction) * random_distance
	
	var spawn_position = airplane.global_position + offset
	
	var active_objective = OBJECTIVE.instantiate()
	add_child(active_objective)
	active_objective.global_position = spawn_position
	temp = active_objective

func objective_done():
	spawn_new_objective()
	score += 1
