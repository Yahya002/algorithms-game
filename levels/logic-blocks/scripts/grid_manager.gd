extends Node2D

const CELL_SIZE = Vector2i(16, 16)

func _ready() -> void:
	Navigator.grid_manager = self
	Navigator.tilemap_layers.append($"../TerrainLayer")

func rebuild_navigation():
	Navigator.astar.clear()

	Navigator.astar.region = $"../TerrainLayer".get_used_rect()
	Navigator.astar.cell_size = CELL_SIZE
	Navigator.astar.offset = CELL_SIZE * 0.5
	Navigator.astar.default_compute_heuristic = AStarGrid2D.HEURISTIC_MANHATTAN
	Navigator.astar.default_estimate_heuristic = AStarGrid2D.HEURISTIC_MANHATTAN
	Navigator.astar.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
	#for cell in used_cells:
		#var blocked := false
#
		#if wall_layer.get_cell_source_id(cell) != -1:
			#blocked = true
#
		#if object_layer.get_cell_source_id(cell) != -1:
			#blocked = true
#
		#if water_layer.get_cell_source_id(cell) != -1:
			#blocked = true
#
		#Navigator.astar.set_point_solid(cell, blocked)

	Navigator.astar.update()
