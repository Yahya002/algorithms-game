extends Node2D

var float_speed := 2.0
var float_amount := 5.0
var start_y := 0.0

func _ready():
	start_y = position.y

func _process(delta):
	position.y = start_y + sin(Time.get_ticks_msec() * 0.005 * float_speed) * float_amount
