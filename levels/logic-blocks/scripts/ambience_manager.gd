extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().create_timer(1.5).timeout
	var length = $Music.stream.get_length()
	var offset = fmod(Time.get_unix_time_from_system(), length)
	$Music.play(offset)
