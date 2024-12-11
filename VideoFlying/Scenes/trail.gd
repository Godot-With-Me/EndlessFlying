class_name Trail
extends Line2D

@export var node : Node2D

const MAX_POINTS : int = 200
@onready var curve = Curve2D.new()

func _process(delta):
	if node.get_parent().visible:
		curve.add_point(node.global_position)
		if curve.get_baked_points().size() > MAX_POINTS:
			curve.remove_point(0)
	else:
		curve.clear_points()
	points = curve.get_baked_points()
