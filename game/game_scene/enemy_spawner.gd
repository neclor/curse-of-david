extends Node


var enemies = [
	preload("res://game/entities/enemies/wizard/wizard.tscn"),
	#preload("res://game/entities/enemies/melee_enemies/knight/knight.tscn"),
	#preload("res://game/entities/enemies/melee_enemies/spearman/spearman.tscn"),
]


@onready var timer: Timer = $Timer
@onready var enemy_container: Node2D = %EnemyContainer
@onready var player: Player = %Player


func _on_timer_timeout():
	create_enemy()


func create_enemy():
	var new_enemy: Enemy = enemies.pick_random().instantiate()
	new_enemy.init(player)
	enemy_container.add_child(new_enemy)
