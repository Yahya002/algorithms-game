extends Node2D

var is_last := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	LogicBlocksGameManager.rails.append(self)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
