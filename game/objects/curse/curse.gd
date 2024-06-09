class_name Curse
extends Node2D


enum Words {
	DAMAGE,
	SLOWDOWN,
	TIME,
	TARGETS,
	VAMPIRISM,
}


var lifetime: int = 0
var time: int = 0


var damage: int = 0
var slowdown_percentage: float = 0
var slowdown_var: float
var vampirism: bool = false
var targets_number: int = 5


var player: Player

var timer: Timer = Timer.new()
var line_2d = Line2D.new()


var colors: PackedColorArray
var points: PackedVector2Array



func set_line(new_points: PackedVector2Array, new_colors: PackedColorArray) -> void:
	colors = new_colors
	points = new_points


func _ready():
	scale = Vector2.ONE * 0.5
	add_child(line_2d)
	line_2d.closed = true
	line_2d.width = 20
	line_2d.joint_mode = Line2D.LINE_JOINT_ROUND
	line_2d.begin_cap_mode = Line2D.LINE_CAP_ROUND
	line_2d.end_cap_mode = Line2D.LINE_CAP_ROUND

	timer.wait_time = 1
	add_child(timer)
	timer.timeout.connect(_on_timer_timeout)
	timer.start()

	var gradient_points: PackedFloat32Array = []
	for i in colors.size():
		gradient_points.append(1.0 / colors.size() * i)

	line_2d.points = points
	line_2d.colors = colors
	line_2d.gradient.offsets = gradient_points

	if get_parent().is_in_group("enemy"):
		slowdown_var = slowdown_percentage * get_parent().speed_multiplier
		get_parent().speed_multiplier -= slowdown_var


func _on_timer_timeout():
	if get_parent().is_in_group("enemy"):
		get_parent().take_damage(damage)
		if player and vampirism:
			player.take_heal(damage / 10)
	time += 1
	if time >= lifetime:
		if get_parent().is_in_group("enemy"):
			get_parent().speed_multiplier += slowdown_var
		queue_free()
