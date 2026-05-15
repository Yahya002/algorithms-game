extends LogicBlock
class_name JumpBlock

@export var position: JUMP_POSITION

enum JUMP_POSITION {
	FRONT,
	MIDDLE,
	END,
}

func _init() -> void:
	title = "Jump"
