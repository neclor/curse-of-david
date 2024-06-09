extends Control


const GAME = preload("res://game/game_scene/game.tscn")
@onready var settings = $Settings

@onready var animation_player = $TextureRect/AnimationPlayer
@onready var animation_player2 = $TextureRect2/AnimationPlayer


func _on_button_pressed():
	get_tree().change_scene_to_packed(GAME)


func _on_button_2_pressed():
	settings.visible = true


func _on_button_mouse_entered():
	animation_player.play("waiting")


func _on_button_mouse_exited():
	animation_player.stop()


func _on_button2_mouse_entered():
	animation_player2.play("waiting")


func _on_button2_mouse_exited():
	animation_player2.stop()
