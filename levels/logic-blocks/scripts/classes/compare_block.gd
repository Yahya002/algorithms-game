extends LogicBlock
class_name CompareBlock

@export var block_queue: Array[LogicBlock]
var condition: COMPARE_CONDITIONS = COMPARE_CONDITIONS.EQUAL
var operand: COMPARE_OPERAND = COMPARE_OPERAND.ORDER

enum COMPARE_CONDITIONS {
	EQUAL,
	GREATER,
	LESSER,
}

enum COMPARE_OPERAND {
	ORDER,
	ADJACENT
}

func _init() -> void:
	title = "Compare"
