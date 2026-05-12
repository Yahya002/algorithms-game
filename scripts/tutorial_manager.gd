extends Node

@onready var audio_player := $"../AudioStreamPlayer"
@onready var anim := $AnimationPlayer

@onready var panel := $"../CanvasLayer/MarginContainer/PanelContainer"
@onready var label := %PromptLabel
@onready var continue_btn := $"../CanvasLayer/MarginContainer/PanelContainer/VBoxContainer/ContinueButton"
@onready var counter := %Counter

@onready var indicator := $"../ArrowIndicator"

var level: Node2D

var lines = [
	"لدينا عدة صناديق موضوعة بشكل عشوائي، إن أردنا البحث عن غرض معيّن سيتوجب علينا المرور على جميع الصناديق.",
	"عند الضغط بـزر الماوس الأيسر على صندوق ما، ستتحرك العربة إلى هذا الصندوق وسيتم فتح كل الصناديق في الطريق.",
	"نريد البحث عن مفتاح الوصول للمرحلة التالية، لمَ لا تجرّب البحث في الصندوق تحت السهم الاحمر؟",
	"إن هذا النهج بطيء وغير عملي، دعنا نبحث في أساليب فعالة أكثر.",
]

var audio_tracks = {
	"text": preload("res://audio/ui/san_andreas_ui_01.mp3"),
	"hide": preload("res://audio/ui/san_andreas_ui_02.mp3")
}

var cursor_sprites = {
	"denied": preload("res://sprites/ui/tile_0015.png"),
	"normal": preload("res://sprites/ui/tile_0027.png"),
}

var targeted_chest

func _ready() -> void:
	Game.game_input_enabled = false
	DisplayServer.cursor_set_custom_image(cursor_sprites["denied"])
	level = get_parent()
	await level.ready
	continue_btn.connect("button_up", on_continue_btn_up)
	await intro()

func intro():
	await anim.animation_finished
	label.text = lines[0]
	await get_tree().create_timer(0.5).timeout

	audio_player.stream = audio_tracks["text"]
	panel.show()
	await continue_btn.button_up
	
	label.text = lines[1]
	await continue_btn.button_up
	
	targeted_chest = get_tree().get_nodes_in_group("chests").get(randi_range(14, get_tree().get_node_count_in_group("chests") - 1))
	targeted_chest.content_sprite.texture = targeted_chest.content_goal["texture"]

	indicator.global_position = targeted_chest.global_position
	
	label.text = lines[2]
	indicator.show()
	counter.show()
	
	await audio_player.finished
	audio_player.stream = audio_tracks["hide"]
	
	await continue_btn.button_up
	panel.hide()

	DisplayServer.cursor_set_custom_image(cursor_sprites["normal"])
	Game.game_input_enabled = true
	
	await targeted_chest.player_arrived
	Game.game_input_enabled = false
	indicator.hide()
	await get_tree().create_timer(1).timeout
	panel.show()
	label.text = lines[3]
	await continue_btn.button_up
	panel.hide()
	counter.hide()
	await get_tree().create_timer(0.5).timeout
	
	anim.play("screen_fade_out")
	await anim.animation_finished
	get_tree().change_scene_to_file("res://levels/bubble-sort/scenes/bubble_sort_level.tscn")

func on_continue_btn_up():
	audio_player.play()
