extends CharacterBody2D

enum State {
	Moving,
	Stopped,
	Held
}

var state: State = State.Moving
var direction: float = 1.0

const SPEED = 256 * 6 * 0.99

func _physics_process(delta):
	if state == State.Moving:
		velocity.x = direction * SPEED
		velocity += get_gravity() * delta
		move_and_slide()
		
		if is_on_wall():
			direction *= -1
			
