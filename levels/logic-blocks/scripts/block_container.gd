extends VBoxContainer

signal block_removed(index)

@onready var list_item_scn = preload("res://levels/logic-blocks/scenes/ui/block_list_item.tscn")

func add_block(block: LogicBlock):
	var list_item = list_item_scn.instantiate()

	list_item.block = block
	list_item.set_label(block.title)
		
	if block is CompareBlock:
		list_item.init_as_compare()

	list_item.connect("remove_pressed", on_remove_pressed)
	add_child(list_item)

func on_remove_pressed(index):
	block_removed.emit(index)
	var block = get_child(index)
	block.queue_free()
