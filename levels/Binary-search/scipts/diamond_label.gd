extends Label

func _ready():
	var player = get_tree().get_first_node_in_group("player")
	var inventory = player.get_node("Inventory")

	text = str(inventory.player_value) 
	
