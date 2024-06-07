extends CharacterBody2D


const POPUP_POINTS: PackedScene = preload("res://game/entities/base_entity/popup_points/popup_points.tscn")


@export_group("Health")
@export var max_hp: int = 100
@export var hp: int = 100


var dead: bool = false


func _ready():
	pass


func _physics_process(_delta):
	pass


func create_isometric_vector(vector: Vector2) -> Vector2:
	var isometric_vector: Vector2 = Vector2(vector.x, vector.y * 2).normalized()
	isometric_vector.y /= 2
	return isometric_vector


func move():
	pass
	func move():
	var input_move_direction_vector = Vector2(Input.get_axis("move_left", "move_right"), Input.get_axis("move_up", "move_down"))
		input_move_direction_vector.y /= 2

		match input_move_direction_vector:
			Vector2(0, 0):
				set_state(State.IDLE)
			_:
				move_direction_vector = normalize_isometric_vector(input_move_direction_vector)
				set_state(State.MOVE)
				one_move()


func create_popup_points(value: int, color: Color) -> void:
	var new_popup_points = POPUP_POINTS.instantiate()
	new_popup_points.set_value(value, color)
	add_child(new_popup_points)


func take_heal(input_heal: int) -> void:
	if input_heal <= 0:
		return
	hp = clamp(hp + input_heal, 0, max_hp)

	create_popup_points(input_heal, Color.GREEN)
	animation_player.play("take_heal")


func take_damage(input_damage: int) -> void:
	if input_damage <= 0:
		return
	hp = clamp(hp - input_damage, 0, max_hp)
	check_death()

	create_popup_points(input_damage, Color.RED)
	animation_player.play("take_damage")


func check_death() -> void:
	if hp > 0:
		return
	die()


func die():
	#Signals.enemy_died
	dead = true
	await animation_player.animation_finished
	animated_sprite_2d.visible = false
	cpu_particles_2d.restart()
	await cpu_particles_2d.finished
	queue_free()
