extends Camera2D

@onready var player = %Player

# Should be called by the player script.
func go(delta):
	if player == null or get_viewport() == null:
		return
	
	global_position = player.global_position
	
	var half_y = get_viewport().size.y * 0.5 / zoom.y
	var half_x = get_viewport().size.x * 0.5 / zoom.x
	
	for limit in get_tree().get_nodes_in_group("CameraLowestY"):
		var limit_pos = limit.global_position.y - half_y
		if global_position.y > limit_pos:
			global_position.y = limit_pos

	for limit in get_tree().get_nodes_in_group("CameraRightmost"):
		var limit_pos = limit.global_position.x - half_x
		if global_position.x > limit_pos:
			global_position.x = limit_pos

	for limit in get_tree().get_nodes_in_group("CameraLeftmost"):
		var limit_pos = limit.global_position.x + half_x
		if global_position.x < limit_pos:
			global_position.x = limit_pos
