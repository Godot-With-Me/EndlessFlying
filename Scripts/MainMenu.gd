extends CanvasLayer

func _on_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/main.tscn")

func _on_button_2_pressed():
	$Shop.visible = true
	$MainButtons.visible = false

func _on_button_3_pressed():
	get_tree().quit()
