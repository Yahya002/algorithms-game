extends Label

func _ready():
	var player = get_tree().get_first_node_in_group("player")
	var inventory = player.get_node("Inventory")

	text = str(inventory.keys) # set initial value
	
	inventory.keys_changed.connect(update_keys)

func update_keys(new_amount):
	text = str(new_amount)
