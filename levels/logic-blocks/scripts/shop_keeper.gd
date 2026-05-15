extends CharacterBody2D

signal order_found
signal order_fulfilled
signal exception_thrown(message)

@export var block_queue: Array[LogicBlock]

var is_reset = true

var is_order_fulfilled := false
var shelf_index: int = 0
var shelf_item

func _ready() -> void:
	LogicBlocksGameManager.shopkeeper = self
	connect("order_fulfilled", LogicBlocksGameManager.on_order_found)
	connect("order_fulfilled", LogicBlocksGameManager.on_order_fulfilled)
	connect("exception_thrown", LogicBlocksGameManager.notify)

func reset():
	is_reset = true
	shelf_index = 0
	position = LogicBlocksGameManager.shelves[0].position + Vector2(0, 16)

func execute(queue: Array[LogicBlock], block_index: int):
	if is_reset or block_index == queue.size():
		return

	var block = queue[block_index]
	shelf_item = LogicBlocksGameManager.shelves[shelf_index]
	
	if block is MoveBlock:
		shelf_index += 1
		shelf_index %= LogicBlocksGameManager.shelves.size()
		position = shelf_item.position + Vector2(0, 16)

	elif block is JumpBlock:
		shelf_index = 0
		position = shelf_item.position + Vector2(0, 16)
	
	elif block is CompareBlock:
		await resolve_compare_block(block)
	
	elif block is ReturnBlock:
		print("BEFORE MOVE ", Time.get_ticks_msec(), position)
		shelf_index = 0
		position = shelf_item.position + Vector2(0, 16)
		print("RETURN MOVE ", Time.get_ticks_msec(), position)
		order_found.emit()
		is_order_fulfilled = true
		await get_tree().process_frame
		print("AFTER FRAME ", Time.get_ticks_msec(), position)

	block_index += 1
	
	$InstructionTimer.start(1)
	$AnimatedSprite2D.play("waiting")
	await  $InstructionTimer.timeout
	$AnimatedSprite2D.play("default")
	
	if is_order_fulfilled:
		print("FULFILLED ", Time.get_ticks_msec(), position)
		order_fulfilled.emit()
		is_order_fulfilled = false
	execute(queue, block_index)

func add_block(block: LogicBlock) -> void:
	block_queue.append(block)

func remove_block(index):
	block_queue.remove_at(index)
	reset()

func _on_play_button_button_up() -> void:
	is_reset = false
	execute(block_queue, 0)

func _on_stop_button_button_up() -> void:
	reset()

func resolve_compare_block(block: LogicBlock):
	var is_condition_true = false
	shelf_item = LogicBlocksGameManager.warehouse[shelf_index]
	var operand
	
	match block.operand:
		CompareBlock.COMPARE_OPERAND.ORDER:
			operand = LogicBlocksGameManager.orders.front()
			if not operand:
				exception_thrown.emit("No Current Order")
				return
		CompareBlock.COMPARE_OPERAND.ADJACENT:
			if shelf_index == LogicBlocksGameManager.warehouse.size():
				reset()
				exception_thrown.emit("Reached Last Item")
				return
			operand = LogicBlocksGameManager.warehouse[shelf_index + 1]
	
	match block.condition:
		CompareBlock.COMPARE_CONDITIONS.GREATER:
			if operand.id > shelf_item.id:
				is_condition_true = true
		CompareBlock.COMPARE_CONDITIONS.EQUAL:
			if operand.id == shelf_item.id:
				is_condition_true = true
		CompareBlock.COMPARE_CONDITIONS.LESSER:
			if operand.id < shelf_item.id:
				is_condition_true = true
	
	if is_condition_true:
		await execute(block.block_queue, 0)
