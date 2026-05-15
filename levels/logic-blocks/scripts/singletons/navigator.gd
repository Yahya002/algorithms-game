extends Node

var astar: AStarGrid2D

var tilemap_layers: Array[TileMapLayer]
var grid_manager: Node2D

var customer_spawner: Node2D
var counter: Node2D

func _ready() -> void:
	astar = AStarGrid2D.new()

func on_tilemap_drawn():
	grid_manager.rebuild_navigation()

func get_point_path_from_global_pos(global_from, global_to) -> PackedVector2Array:
	var local_from = tilemap_layers[0].to_local(global_from)
	var local_to = tilemap_layers[0].to_local(global_to)
	var map_from = tilemap_layers[0].local_to_map(local_from)
	var map_to = tilemap_layers[0].local_to_map(local_to)
	
	return astar.get_point_path(map_from, map_to)
