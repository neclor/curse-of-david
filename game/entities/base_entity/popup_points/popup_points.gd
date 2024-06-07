extends Node2D


@onready var points_label: Label = $PointsContainer/PointsLabel


func set_value(new_value: int, new_color: Color) -> void:
	points_label.text = str(new_value)
	points_label.modulate = new_color


func remove() -> void:
	queue_free()
