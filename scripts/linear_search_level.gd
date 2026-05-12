extends Node2D

@onready var path_follow = $Path2D/PathFollow2D
@onready var target_position: Vector2 = $Path2D/PathFollow2D.global_position
@onready var rail_track_audio := $Path2D/PathFollow2D/PlayerWagon/RailtrackAudio

const MIN_DISTANCE = 0.1
const SPEED = 0.08

var target_chest
var should_move := false
var movements := 0

func _ready() -> void:
	await get_tree().process_frame
	for chest in get_tree().get_nodes_in_group("chests"):
		chest.chest_pressed.connect(on_chest_pressed)
		chest.player_arrived.connect(on_player_arrived)

func initialize():
	path_follow.progress_ratio = 0.0
	for chest in get_tree().get_nodes_in_group("chests"):
		chest.initialize()

func _process(delta: float) -> void:
	move(delta)

func on_chest_pressed(chest):
	target_chest = chest
	should_move = true
	rail_track_audio.play()
	pass

func on_player_arrived(chest):
	movements += 1
	%Counter.text = "الخطوات: " + str(movements)
	if chest == target_chest:
		should_move = false
		rail_track_audio.stop()

func move(delta: float):
	if should_move:
		path_follow.progress_ratio += SPEED * delta
