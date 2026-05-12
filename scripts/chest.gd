extends Node2D

signal chest_pressed(chest)
signal player_arrived(chest)

@export var content: String


@onready var anim = get_child(0)
@onready var content_sprite := $Sprite2D/ContentSprite
@onready var content_options = [
	{
		"weight": 1,
		"texture": preload("res://sprites/objects/tile_0404.png")
	},
	{
		"weight": 2,
		"texture": preload("res://sprites/objects/tile_0405.png")
	},
	{
		"weight": 4,
		"texture": preload("res://sprites/objects/tile_0406.png")
	},
]

@onready var content_goal = {
		"weight": 3,
		"texture": preload("res://sprites/objects/tile_0403.png")
	}

var weight = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("chests")
	$Label.text = str(get_tree().get_node_count_in_group("chests"))
	var option = content_options.pick_random()
	content_sprite.texture = option["texture"]
	weight = option["weight"]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func initialize():
	close()

func close():
	anim.play("RESET")

func set_as_goal():
	content_sprite.texture = content_goal["texture"]
	weight = content_goal["weight"]

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if not Game.game_input_enabled:
		return
	
	if event is InputEventMouseButton:
		if event.button_index == MouseButton.MOUSE_BUTTON_LEFT and event.is_pressed():
			if not anim.assigned_animation == "open":
				chest_pressed.emit(self)


func _on_area_2d_2_area_entered(area: Area2D) -> void:
	anim.play("open")
	player_arrived.emit(self)


func _on_left_comparator_area_entered(area: Area2D) -> void:
	GameManager.left_comparator = self


func _on_left_comparator_area_exited(area: Area2D) -> void:
	GameManager.left_comparator = null


func _on_right_comparator_area_entered(area: Area2D) -> void:
	GameManager.right_comparator = self


func _on_right_comparator_area_exited(area: Area2D) -> void:
	GameManager.right_comparator = null
