extends CharacterBody2D

const BASE_MOVE_SPEED := 20

var state := STATES.IDLE
var order: ProductData
var target: Node2D
var is_order_fulfilled := false

enum STATES {
	IDLE,
	WAITING,
	MOVING,
}

func set_order_texture():
	$Sprite2D2.texture = order.texture.duplicate()

func _process(delta: float) -> void:
	match state:
		STATES.IDLE:
			if order:
				state = STATES.MOVING
			else:
				print("no order: ", self)
		STATES.MOVING:
			var arrived = move(delta)
			if arrived:
				if is_order_fulfilled:
					queue_free()
				else:
					state = STATES.WAITING
		STATES.WAITING:
			if is_order_fulfilled:
				target = Navigator.customer_spawner
				state = STATES.MOVING

func move(delta):
	var path = Navigator.get_point_path_from_global_pos(global_position, target.global_position + Vector2(0, 16))
	path.remove_at(0)
	if path.is_empty():
		return true
	var next_point = path[0]
	velocity = (next_point - global_position).normalized() * BASE_MOVE_SPEED
	move_and_slide()

func leave():
	await get_tree().create_timer(3).timeout
	is_order_fulfilled = true
