extends Node2D

@onready var customer_scn = preload("res://levels/logic-blocks/scenes/customer.tscn")

func _ready() -> void:
	%Timer.start(LogicBlocksGameManager.order_interval)
	%Timer.connect("timeout", spawn_customer)
	
	Navigator.customer_spawner = self

func spawn_customer():
	var customer = customer_scn.instantiate()
	var order = LogicBlocksGameManager.product_catalog.pick_random().duplicate(true)
	customer.order = order
	customer.set_order_texture()
	customer.target = Navigator.counter
	add_child(customer)
	
	LogicBlocksGameManager.orders.append(order)
	LogicBlocksGameManager.customers.append(customer)
