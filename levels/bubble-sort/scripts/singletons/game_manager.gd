extends Node

var level

var left_comparator:
	set(chest):
		if right_comparator:
			trigger_comparison()
		else:
			level.trigger_game_end()
var right_comparator

func trigger_comparison():
		if left_comparator.weight > right_comparator.weight:
			left_comparator.anim.play("weigh_more")
			right_comparator.anim.play("weigh_less")
		elif left_comparator.weight < right_comparator.weight:
			left_comparator.anim.play("weigh_less")
			right_comparator.anim.play("weigh_more")
		elif left_comparator.weight == right_comparator.weight:
			left_comparator.anim.play("weigh_same")
			right_comparator.anim.play("weigh_same")
		level.trigger_comparison()

func swap():
	left_comparator.anim.play("shift_right")
	right_comparator.anim.play("shift_left")
	await left_comparator.anim.animation_finished("shift_right")
	var temp_pos = left_comparator.global_position
	left_comparator.global_position = right_comparator.global_position
	right_comparator.global_position = temp_pos
	
	level.trigger_sawp_end()
