extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_linear_search_button_down() -> void:
	get_tree().change_scene_to_file("res://scenes/linear_search_level.tscn")


func _on_binary_search_button_down() -> void:
	get_tree().change_scene_to_file("res://levels/Binary-search/scenes/binary-search-level.tscn")
	pass
