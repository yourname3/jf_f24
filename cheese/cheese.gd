extends CharacterBody2D

enum State {
	Moving,
	Stopped,
	Held
}

var state: State = State.Stopped
var direction: float = 1.0

var release_invuln = 0.0

const SPEED = 256 * 6 * 0.99

func _physics_process(delta):
	if release_invuln > 0.0:
		release_invuln -= delta
	else:
		# We are a hazard while we are moving.
		# We have a small timer to prevent this during the item throw.
		set_collision_layer_value(2, (state == State.Moving))
	if state == State.Moving:
		velocity.x = direction * SPEED
		velocity += get_gravity() * delta
		move_and_slide()
		
		if is_on_wall():
			direction *= -1
	elif state == State.Stopped:
		velocity.x = 0
		velocity += get_gravity() * delta
		move_and_slide()
			
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
	
func release(direction: float):
	assert(state == State.Held)
	state = State.Moving
	self.direction = direction
	
	release_invuln = 0.3
