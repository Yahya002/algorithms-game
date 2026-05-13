extends HFlowContainer

signal remove_pressed(index)
signal option_selected(index, key, value)

func set_label(text):
	$Label.text = text

func init_as_jump():
	pass

func init_as_compare():
	$OptionButton.show()
	$OptionButton.add_item("Order")
	$OptionButton.add_item("Adjacent")
	
	$OptionButton2.show()
	$OptionButton2.add_item("Greater", CompareBlock.COMPARE_CONDITIONS.GREATER)
	$OptionButton2.add_item("Equal", CompareBlock.COMPARE_CONDITIONS.EQUAL)
	$OptionButton2.add_item("Lesser", CompareBlock.COMPARE_CONDITIONS.LESSER)
	
	option_selected.connect(LogicBlocksGameManager.edit_block)
	
func _on_button_button_up() -> void:
	remove_pressed.emit(get_index())


func _on_option_button_item_selected(index: int) -> void:
	var value = $OptionButton.get_item_text(index)
	option_selected.emit(get_index(), "operand", value)


func _on_option_button_2_item_selected(index: int) -> void:
	var value = $OptionButton2.get_item_id(index)
	option_selected.emit(get_index(), "condition", value)
