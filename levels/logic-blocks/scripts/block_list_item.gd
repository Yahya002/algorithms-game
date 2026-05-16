extends VBoxContainer

signal remove_pressed(index)
signal option_selected(index, key, value)

var block: LogicBlock

func set_label(text):
	%Label.text = text

func init_as_jump():
	pass

func init_as_compare():
	%OptionButton1.show()
	%OptionButton1.add_item("Order")
	%OptionButton1.add_item("Adjacent")
	
	%OptionButton2.show()
	%OptionButton2.add_item("Greater", CompareBlock.COMPARE_CONDITIONS.GREATER)
	%OptionButton2.add_item("Equal", CompareBlock.COMPARE_CONDITIONS.EQUAL)
	%OptionButton2.add_item("Lesser", CompareBlock.COMPARE_CONDITIONS.LESSER)

	var block_panel = load("res://levels/logic-blocks/scenes/ui/block_panel.tscn").instantiate()
	block_panel.list_item = self
	add_child(block_panel)

func _on_button_button_up() -> void:
	remove_pressed.emit(get_index())

func _on_option_button_item_selected(index: int) -> void:
	var value = %OptionButton1.get_item_text(index)
	block.operand = value

func _on_option_button_2_item_selected(index: int) -> void:
	var value = %OptionButton2.get_item_id(index)
	block.condition = value

func on_block_added(new_block):
	block.block_queue.append(new_block)

func on_block_removed(index):
	block.block_queue.remove_at(index)
