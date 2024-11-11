extends CanvasLayer

func _ready():
	get_tree().paused = false
	visible = false
	
	process_mode = ProcessMode.PROCESS_MODE_ALWAYS

func _process(delta):
	if Input.is_action_just_pressed("pause"):
		get_tree().paused = not get_tree().paused
		
	visible = get_tree().paused

func _on_restart_pressed():
	var player = get_node("%Player")
	if player != null:
		player.die()

func _on_quit_pressed():
	SceneTransition.change_to(Globals.Gallery)

func _on_main_menu_pressed():
	SceneTransition.change_to(Globals.MainMenu)
