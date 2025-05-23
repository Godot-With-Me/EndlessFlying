extends CanvasLayer

const SCREEN_MARGIN_START = 8
const SCREEN_MARGIN_END = 24

@onready var marker = $Marker
@onready var airplane = %Airplane

const WARNING = preload("res://Scenes/Templates/warning.tscn")

var objective_pos : Vector2

var screen_size

var missiles = {}

func _process(delta):
	screen_size = get_viewport().get_visible_rect().size
	set_marker_pos(objective_pos, marker)
	for node_path in missiles:
		set_marker_pos(node_path.global_position, missiles[node_path])
	
func set_marker_pos(obj_pos, ui_node):
	var direction = (obj_pos - airplane.get_node("Camera2D").get_screen_center_position()) * airplane.get_node("Camera2D").zoom.x
	var target_position = direction + screen_size / 2 - Vector2(8, 8)
	
	target_position.x = clamp(target_position.x, SCREEN_MARGIN_START, screen_size.x - SCREEN_MARGIN_END)
	target_position.y = clamp(target_position.y, SCREEN_MARGIN_START, screen_size.y - SCREEN_MARGIN_END)
	
	if target_position.x > SCREEN_MARGIN_START && target_position.x < screen_size.x - SCREEN_MARGIN_END && target_position.y > SCREEN_MARGIN_START && target_position.y < screen_size.y - SCREEN_MARGIN_END:
		ui_node.visible = false
	else:
		ui_node.visible = true
	
	ui_node.position = target_position

func set_objective_pos(pos):
	objective_pos = pos

func add_missile(node):
	var instance = WARNING.instantiate()
	add_child(instance)
	missiles[node] = instance
	
func remove_missile(node):
	missiles[node].queue_free()
	missiles.erase(node)

func is_dead():
	$DeathScreen.visible = true

#RESTART
func _on_button_pressed():
	Engine.time_scale = 1
	get_tree().reload_current_scene()

#MAINMENU
func _on_button_2_pressed():
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")
