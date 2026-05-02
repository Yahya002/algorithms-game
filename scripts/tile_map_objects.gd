extends TileMapLayer


# Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#for chest in get_children():
		#chest.chest_pressed()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func get_overlapping_chest(global_pos: Vector2):
	var local_pos = to_local(global_pos)
	var coords = local_to_map(local_pos)
	
	if get_cell_source_id(coords) > -1:
		coords.y += 1
		global_pos = to_global(map_to_local(coords))
		return global_pos
	return null
