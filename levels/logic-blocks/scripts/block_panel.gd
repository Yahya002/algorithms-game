extends MarginContainer

signal block_added(block)
signal block_removed(index)

@export var is_top: bool
@export var block_types: Array[LogicBlock]

var list_item: Control

func _ready() -> void:
	%OptionButton.connect("item_selected", on_block_list_item_added)
	%BlockContainer.connect("block_removed", on_block_list_item_removed)
	
	for type in block_types:
		%OptionButton.add_item(type.title)
		
	if is_top:
		LogicBlocksGameManager.block_container = self
		connect("block_added", LogicBlocksGameManager.add_block)
		connect("block_removed", LogicBlocksGameManager.remove_block)
	else:
		connect("block_added", list_item.on_block_added)
		connect("block_removed", list_item.on_block_removed)

func on_block_list_item_added(index):
	#%OptionButton.get_item_metadata(index)
	var block = block_types[index].duplicate(true)
	%BlockContainer.add_block(block)
	block_added.emit(block)

func on_block_list_item_removed(index):
	block_removed.emit(index)
