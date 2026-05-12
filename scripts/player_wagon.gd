extends Node2D

@onready var anim := $AnimationPlayer
@onready var player := $RailTurnAudio

var sounds = [
	preload("res://audio/creak1.ogg"),
	preload("res://audio/creak2.ogg"),
	preload("res://audio/creak3.ogg"),
]

func _on_player_area_area_entered(area: Area2D) -> void:
	if area is AnimationTriggerArea:
		if anim.has_animation(area.anim):
			anim.play(area.anim)
			play_creek_sound()


func play_creek_sound():
	player.stream = sounds.pick_random()
	player.play()
