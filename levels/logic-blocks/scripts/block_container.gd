extends VBoxContainer

signal block_removed(index)

@onready var list_item_scn = preload("res://levels/logic-blocks/scenes/ui/block_list_item.tscn")

func _ready() -> void:
	LogicBlocksGameManager.block_container = self
	connect("block_removed", LogicBlocksGameManager.remove_block)

func add_block(block):
	var list_item = list_item_scn.instantiate()

	if block is MoveBlock:
		list_item.set_label("Move")
		
	elif block is JumpBlock:
		list_item.set_label("Jump")
		
	elif block is CompareBlock:
		list_item.set_label("Compare")
		list_item.init_as_compare()
#
	elif block is ReturnBlock:
		pass
	
	list_item.connect("remove_pressed", on_remove_pressed)
	add_child(list_item)

func on_remove_pressed(index):
	block_removed.emit(index)
	var block = get_child(index)
	block.queue_free()
