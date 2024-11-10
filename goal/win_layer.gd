extends CanvasLayer

func _ready():
	hide()
	
func _on_back_pressed():
	SceneTransition.change_to(Globals.Gallery)
