extends Button

@onready var color_rect = $ColorRect
@onready var obj_texture = $TextureRect
@onready var lock_texture = $TextureRect2
@onready var label = $Label

var item_dict
var _main_menu

var is_unlocked: bool = false

func setup_item(dict, main_menu):
	item_dict = dict
	_main_menu = main_menu
	label.text = str(dict.price)
	obj_texture.texture = load(dict.asset)
	
	if Global.save_dict[dict.type + "s"][dict.index] == true:
		lock_texture.visible = false
		label.visible = false
		is_unlocked = true
	
	if Global.save_dict["curr_" + dict.type] != dict.index:
		color_rect.visible = false
	
	self.pressed.connect(_on_pressed)

func _on_pressed():
	if Global.save_dict[item_dict.type + "s"][item_dict.index] == true:
		_main_menu.clear_current(item_dict.type)
		selected(true)
		Global.save_dict["curr_" + item_dict.type] = item_dict.index
	elif Global.save_dict.money >= item_dict.price:
		Global.save_dict.money -= item_dict.price
		Global.save_dict[item_dict.type + "s"][item_dict.index] = true
		
		label.visible = false
		lock_texture.visible = false
		
		_main_menu.clear_current(item_dict.type)
		selected(true)
		Global.save_dict["curr_" + item_dict.type] = item_dict.index

func selected(on: bool):
	if on:
		color_rect.visible = true
	else:
		color_rect.visible = false
