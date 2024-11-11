extends TileMap

# Simple way to sample grass with varying probabilities.
var grass_options = [4, 4, 4, 4, 4, 4, 4, 4, 5, 5, 5, 6]

func add_grass():
	for tile in get_used_cells_by_id(0, 0):
		var above_tile = tile + Vector2i(0, -1)
		var above_id = get_cell_source_id(0, above_tile)
		# If there is empty space above a grass tile, replace it with a grass particle tile.
		if above_id == -1:
			var which = grass_options.pick_random()
			set_cell(0, above_tile, which, Vector2i(0, 0), 0)

func _ready():
	add_grass()
