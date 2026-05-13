extends Node

var level
var shopkeeper
var block_container

var product_catalog: Array[ProductData]
var order_interval = 10.0
var warehouse = []
var products = []
var rails: Array[Node2D]

var product_scn = preload("res://levels/logic-blocks/scenes/product.tscn")

var shelves: Array[Node2D]

func generate_warehouse():
	for shelf in shelves:
		warehouse.append(product_catalog.pick_random())
		var product = product_scn.instantiate()
		product.setup(warehouse.back())
		product.position = shelf.position
		products.append(product)
		level.add_child(product)

	#shopkeeper.execute()

func add_block_ui(block):
	block_container.add_block(block)

func remove_block(index):
	shopkeeper.remove_block(index)

func edit_block(index, key, value):
	shopkeeper.edit_block(index, key, value)
