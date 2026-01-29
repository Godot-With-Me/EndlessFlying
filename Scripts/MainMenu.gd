extends CanvasLayer

const ITEM = preload("res://Scenes/item.tscn")

@onready var grid_container = $Shop/GridContainer

var item_arr = [
	{"asset": "res://Assets/airplane1.png", "price": 0, "type": "plane", "index": 0},
	{"asset": "res://Assets/airplane2.png", "price": 5, "type": "plane", "index": 1},
	{"asset": "res://Assets/airplane3.png", "price": 10, "type": "plane", "index": 2},
	{"asset": "res://Assets/airplane4.png", "price": 15, "type": "plane", "index": 3},
	{"asset": "res://Assets/trail1.png", "price": 0, "type": "trail", "index": 0},
	{"asset": "res://Assets/trail2.png", "price": 5, "type": "trail", "index": 1},
	{"asset": "res://Assets/trail3.png", "price": 10, "type": "trail", "index": 2},
	{"asset": "res://Assets/trail4.png", "price": 15, "type": "trail", "index": 3},
]

func _ready():
	for item in item_arr:
		var instance = ITEM.instantiate()
		grid_container.add_child(instance)
		instance.setup_item(item, self)
		item.node = instance

func _on_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/main.tscn")

func _on_button_2_pressed():
	$Shop.visible = true
	$MainButtons.visible = false

func _on_button_3_pressed():
	Global.save()
	get_tree().quit()

func clear_current(type: String):
	for item in item_arr:
		if item.type == type && item.index == Global.save_dict["curr_" + type]:
			item.node.selected(false)
			return

func _on_exit_pressed():
	$Shop.visible = false
	$MainButtons.visible = true
