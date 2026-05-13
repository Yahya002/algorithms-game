extends Node2D

@export var product_catalog: Array[ProductData]

signal catalog_loaded

func _ready() -> void:
	LogicBlocksGameManager.product_catalog = product_catalog
	await get_tree().process_frame
	LogicBlocksGameManager.level = self
	connect("catalog_loaded", LogicBlocksGameManager.generate_warehouse)
	catalog_loaded.emit()
	
