extends Node2D

signal chest_pressed(chest)
signal player_arrived(chest)

@onready var anim = get_child(0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("chests")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MouseButton.MOUSE_BUTTON_LEFT and event.is_pressed():
			#print("pressed: ", global_position)
			chest_pressed.emit(self)


func _on_area_2d_2_area_entered(area: Area2D) -> void:
	print("arrived")
	anim.play("open")
	player_arrived.emit(self)
