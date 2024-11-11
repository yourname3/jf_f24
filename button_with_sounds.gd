extends Button

func _on_mouse_entered():
	Sounds.hover_on.play()
	
func _on_mouse_exited():
	Sounds.hover_off.play()

func _ready():
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
