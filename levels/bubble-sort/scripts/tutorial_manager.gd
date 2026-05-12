extends Node

var lines = [
	"من المنطقي ان نقوم بعملية ترتيب لتسهيل البحث مستقبلاً، لمَ لا نجرّب الترتيب الفقاعي؟",
	""
]

var level
@onready var anim := $AnimationPlayer
@onready var audio_player := $AudioStreamPlayer
@onready var label := %Label
@onready var continue_btn := %ContinueButton
@onready var swap_btn := %SwapButton

func _ready() -> void:
	level = get_parent()
	
	await level.ready
	await intro()

func intro():
	await anim.animation_finished
	Game.game_input_enabled = false
	
	await get_tree().create_timer(0.5).timeout
