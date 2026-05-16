extends Node

signal keys_changed(new_amount)

var keys: int = 4
var player_value : int = 8
func has_key() -> bool:
	return keys > 0

func use_key():
	if keys > 0:
		keys -= 1
		emit_signal("keys_changed", keys)

func add_key(amount: int):
	keys += amount
	emit_signal("keys_changed", keys)
