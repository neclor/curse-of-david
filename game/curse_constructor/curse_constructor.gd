extends CanvasLayer


const CURSE_WORD_BUTTON = preload("res://game/curse_constructor/curse_word_button/curse_word_button.tscn")


var word_positions: Array = []
var available_words: Array[Curse.Words] = [Curse.Words.DAMAGE, Curse.Words.SLOWDOWN, Curse.Words.TIME, Curse.Words.TARGETS, Curse.Words.VAMPIRISM]


@onready var line_2d = $Node2D/Line2D
@onready var button_container = $ButtonContainer

var start_button_index: int = -1
var first_button = true

var new_curse: Curse = Curse.new()


func init(new_available_words: Array[Curse.Words]) -> void:
	available_words = new_available_words



func _ready():
	for i in 7:
		word_positions.append(Vector2.UP.rotated(TAU / 7 * i) * 450 + Vector2(1920, 1080) / 2 - Vector2(128, 128))
		
	generate_new_buttons()


func generate_new_buttons():
	available_words.shuffle()
	word_positions.shuffle()
	for i in clamp(word_positions.size(), 0, clamp(available_words.size(), 2, 3)):
		var new_button = CURSE_WORD_BUTTON.instantiate()

		new_button.position = word_positions[i]

		var word = available_words[i]
		var value
		match word:
			Curse.Words.DAMAGE:
				value = randi_range(15, 25)
			Curse.Words.SLOWDOWN:
				value = snappedf(randf_range(0.1, 0.2), 0.01)
			Curse.Words.TIME:
				value = randi_range(1, 3)
			Curse.Words.TARGETS:
				value = randi_range(5, 10)
			Curse.Words.VAMPIRISM:
				available_words.remove_at(i)
				value = true

		new_button.init(word, value)
		button_container.add_child(new_button)
		new_button.button_was_pressed.connect(button_pressed)



func button_pressed(button, word, value):
	if button.first_button:
		

	word_positions.erase(button.position)
	match word:
		Curse.Words.DAMAGE:
			new_curse.damage += value
		Curse.Words.SLOWDOWN:
			new_curse.slowdown_percentage += value
		Curse.Words.TIME:
			new_curse.time += value
		Curse.Words.TARGETS:
			new_curse.targets_number += value
		Curse.Words.VAMPIRISM:
			new_curse.vampirism = true

	if first_button:
		first_button = false
		button.set_first_button()

	for btn in button_container.get_children():
		btn.remove()

	generate_new_buttons()
