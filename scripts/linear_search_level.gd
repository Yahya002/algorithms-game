extends Node2D

@onready var path_follow = $Path2D/PathFollow2D
@onready var target_position: Vector2 = $Path2D/PathFollow2D.global_position

const MIN_DISTANCE = 0.1
const SPEED = 0.08

var target_chest
var should_move := false

func _ready() -> void:
	for chest in get_tree().get_nodes_in_group("chests"):
		print("connected")
		chest.chest_pressed.connect(on_chest_pressed)
		chest.player_arrived.connect(on_player_arrived)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		for chest in get_tree().get_nodes_in_group("chests"):
			print("connected")
			chest.chest_pressed.connect(on_chest_pressed)
			chest.player_arrived.connect(on_player_arrived)
	move(delta)

func on_chest_pressed(chest):
	print(chest.position)
	target_chest = chest
	should_move = true
	pass

func on_player_arrived(chest):
	if chest == target_chest:
		should_move = false

func move(delta: float):
	if should_move:
		$Path2D/PathFollow2D.progress_ratio += SPEED * delta
