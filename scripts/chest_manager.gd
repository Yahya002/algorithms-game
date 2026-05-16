extends Node

var chests: Array = []
var player_value: int = 0


func _ready():
	await get_tree().process_frame

	chests = get_tree().get_nodes_in_group("chests")
	sort_chests()
	clean_chests()
	update_middle_pointer()

	var player = get_tree().get_first_node_in_group("player")
	if player and player.has_node("Inventory"):
		var inventory = player.get_node("Inventory")
		player_value = inventory.player_value

func sort_chests():
	chests.sort_custom(_sort_by_value)


func _sort_by_value(a, b):
	return a.chest_value < b.chest_value


# Called when ANY chest is opened
func chest_opened(opened_chest):

	clean_chests()

	if chests.is_empty():
		return

	var mid_index: int = chests.size() / 2
	var middle_chest = chests[mid_index]

	# If not middle → do nothing
	if opened_chest != middle_chest:
		print("Not middle chest. Nothing happens.")
		return

	print("Middle chest opened.")

	# Binary logic
	if player_value == middle_chest.chest_value:
		print("Correct! You found it!")
		return

	elif player_value > middle_chest.chest_value:
		remove_left_half(mid_index)

	else:
		remove_right_half(mid_index)


func remove_left_half(mid_index):

	for i in range(mid_index, -1, -1):
		if is_instance_valid(chests[i]):
			chests[i].queue_free()

	chests = chests.slice(mid_index + 1, chests.size())

	clean_chests()
	update_middle_pointer()


func remove_right_half(mid_index):

	for i in range(chests.size() - 1, mid_index - 1, -1):
		if is_instance_valid(chests[i]):
			chests[i].queue_free()

	chests = chests.slice(0, mid_index)

	clean_chests()
	update_middle_pointer()


func update_middle_pointer():

	clean_chests()

	# Hide all pointers safely
	for chest in chests:
		if is_instance_valid(chest):
			chest.hide_pointer()

	if chests.is_empty():
		return

	var mid_index: int = chests.size() / 2
	var middle_chest = chests[mid_index]

	if is_instance_valid(middle_chest):
		middle_chest.show_pointer()


# Removes freed nodes from the array
func clean_chests():
	var valid_chests: Array = []

	for chest in chests:
		if is_instance_valid(chest):
			valid_chests.append(chest)

	chests = valid_chests
