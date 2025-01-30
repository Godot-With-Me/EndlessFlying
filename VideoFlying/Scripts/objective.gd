extends Sprite2D

var inside = false
var main
var done = false

func _ready():
	main = get_tree().get_root().get_child(0)

func _input(event):
	if event.is_action_pressed("drop") && inside && !done:
		main.objective_done()
		done = true
		$ObjectiveCircle.queue_free()
		await get_tree().create_timer(15).timeout
		self.queue_free()

func _on_area_2d_body_entered(_body):
	inside = true

func _on_area_2d_body_exited(_body):
	inside = false
