extends Node

var level: Node2D
var shopkeeper: CharacterBody2D
var block_container: Control

var label: Label

var product_catalog: Array[ProductData]
var order_interval := 5.0
var orders: Array[ProductData]
var customers: Array[CharacterBody2D]

var warehouse = []
var products = []

var product_scn = preload("res://levels/logic-blocks/scenes/product.tscn")

var shelves: Array[Node2D]

func _ready() -> void:
	Engine.set_max_fps(60)

func generate_warehouse():
	for shelf in shelves:
		warehouse.append(product_catalog.pick_random())
		var product = product_scn.instantiate()
		product.setup(warehouse.back())
		product.position = shelf.position
		products.append(product)
		level.add_child(product)


func add_block(block):
	shopkeeper.add_block(block)

func edit_block(index, key, value):
	shopkeeper.edit_block(index, key, value)

func remove_block(index):
	shopkeeper.remove_block(index)

func on_order_found():
	label.text = "found"

func on_order_fulfilled():
	var customer = customers.pop_front()
	var order = orders.pop_front()
	customer.leave()
	label.text = "waiting"
	#order.unreference()
	#order.free()

func notify(message):
	pass
