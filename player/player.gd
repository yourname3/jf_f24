extends CharacterBody2D

const H_ACCEL = 1400.0
const SPEED = 256.0 * 6
const JUMP_VELOCITY = -2000.0


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("player_jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("player_left", "player_right")
	var target_speed = direction * SPEED
	var accel = H_ACCEL
	if sign(velocity.x) != sign(target_speed):
		accel *= 2
	velocity.x = move_toward(velocity.x, target_speed, accel * delta)

	move_and_slide()
