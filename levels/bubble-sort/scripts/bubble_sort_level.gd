extends Node2D

@onready var tutorial_manager := $TutorialManager

signal comparison_triggered
signal swap_ended
signal game_ended

const SPEED = 1

var should_move := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.level = self

func _process(delta: float) -> void:
	if should_move:
		$Path2D/PathFollow2D.progress_ratio += SPEED * delta

func trigger_comparison():
	should_move = false
	comparison_triggered.emit()

func trigger_swap_end():
	should_move = true
	swap_ended.emit()

func trigger_game_end():
	should_move = false
	game_ended.emit()
