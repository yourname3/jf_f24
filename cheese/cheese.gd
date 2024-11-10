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
	# We are a hazard while we are moving.
	set_collision_layer_value(2, (state == State.Moving))
	if state == State.Moving:
		
		
		velocity.x = direction * SPEED
		velocity += get_gravity() * delta
		move_and_slide()
		
		if is_on_wall():
			direction *= -1
			
func _on_player_on_cheese_body_entered(body):
	# The player hit the top -- we set our state to stopped and tell the player
	# that we jumped.
	if state == State.Moving:
		state = State.Stopped
		body.cheese_jump()
		
func pickup() -> bool:
	if state == State.Stopped:
		state = State.Held
		return true
	return false
