extends Area2D

var won = false

func _on_body_entered(body):
	if not won:
		won = true
		Sounds.hooray.play()
	%WinLayer.show()
