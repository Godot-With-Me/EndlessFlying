extends Node2D

@onready var ground = $ParallaxBackground/Ground
@onready var sprite_ground = $ParallaxBackground/Ground/Sprite2D

@onready var clouds = $ParallaxBackground/Clouds
@onready var color_rect_clouds = $ParallaxBackground/Clouds/ColorRect

func _process(delta):
	var screen_max_size = max(get_viewport().get_visible_rect().size.x, get_viewport().get_visible_rect().size.y)
	
	ground.motion_mirroring = Vector2(screen_max_size, screen_max_size)
	sprite_ground.scale = Vector2(screen_max_size / 16, screen_max_size / 16)
	sprite_ground.position = Vector2(screen_max_size / 2, screen_max_size / 2)
	
	clouds.motion_mirroring = Vector2(screen_max_size, screen_max_size)
	color_rect_clouds.size = Vector2(screen_max_size, screen_max_size)
