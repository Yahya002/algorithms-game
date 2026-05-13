extends CharacterBody2D

@export var block_queue: Array[LogicBlock]
@export var order: ProductData

signal block_added(block)

#var block_index: int = 0
var shelf_index: int = 0

var is_reset = true

func _ready() -> void:
	LogicBlocksGameManager.shopkeeper = self
	connect("block_added", LogicBlocksGameManager.add_block_ui)

func reset():
	#block_index = 0
	shelf_index = 0
	position = LogicBlocksGameManager.shelves[0].position + Vector2(0, 16)

func execute(queue: Array[LogicBlock], block_index: int):
	$InstructionTimer.start(1)
	await  $InstructionTimer.timeout
	#if is_reset or block_index == queue.size():
	if is_reset:
		return
	
	if queue[block_index] is MoveBlock:
		shelf_index += 1
		shelf_index %= LogicBlocksGameManager.shelves.size()
		position = LogicBlocksGameManager.shelves[shelf_index].position + Vector2(0, 16)

	elif queue[block_index] is JumpBlock:
		shelf_index = 0
		position = LogicBlocksGameManager.shelves[shelf_index].position + Vector2(0, 16)
	
	elif queue[block_index] is CompareBlock:
		print("compare: ")
		match queue[block_index].condition:
			CompareBlock.COMPARE_CONDITIONS.GREATER:
				if order.id > LogicBlocksGameManager.warehouse[shelf_index].id:
					print("greater")
				else:
					block_index += 1
			CompareBlock.COMPARE_CONDITIONS.EQUAL:
				if order.id == LogicBlocksGameManager.warehouse[shelf_index].id:
					print("equal")
				else:
					block_index += 1
			CompareBlock.COMPARE_CONDITIONS.LESSER:
				if order.id < LogicBlocksGameManager.warehouse[shelf_index].id:
					print("lesser")
				else:
					block_index += 1
	
	elif queue[block_index] is ReturnBlock:
		pass

	block_index += 1
	block_index %= queue.size()

	execute(queue, block_index)


func _on_option_button_item_selected(index: int) -> void:
	var text = %OptionButton.get_item_text(index)
	var block
	match text:
		"Move":
			block_queue.append(MoveBlock.new())
			block_added.emit(MoveBlock.new())
		"Jump":
			block_queue.append(JumpBlock.new())
			block_added.emit(JumpBlock.new())
		"Compare":
			block = CompareBlock.new()
			block_queue.append(block)
			block_added.emit(block)
		"Return":
			block_queue.append(ReturnBlock.new())
			block_added.emit(ReturnBlock.new())

func edit_block(index, key, value):
	match key:
		"operand":
			block_queue[index].operand = value
		"condition":
			block_queue[index].condition = value
			

func remove_block(index):
	block_queue.remove_at(index)
	reset()
	is_reset = true

func _on_play_button_button_up() -> void:
	is_reset = false
	execute(block_queue, 0)

func _on_stop_button_button_up() -> void:
	reset()
	is_reset = true
