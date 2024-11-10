extends Camera2D

@onready var player = %Player

# Should be called by the player script.
func go(delta):
	global_position = player.global_position
	
	var half_y = get_viewport().size.y * 0.5 / zoom.y
	
	for limit in get_tree().get_nodes_in_group("CameraLowestY"):
		var limit_pos = limit.global_position.y - half_y
		if global_position.y > limit_pos:
			global_position.y = limit_pos
