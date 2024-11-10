extends CharacterBody2D

const H_ACCEL = 1400.0
const SPEED = 256.0 * 6
const JUMP_VELOCITY = -2000.0

@onready var sprite = $Sprite

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("player_jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Horizontal acceleration
	var direction = Input.get_axis("player_left", "player_right")
	var target_speed = direction * SPEED
	var accel = H_ACCEL
	if sign(velocity.x) != sign(target_speed):
		accel *= 2
	velocity.x = move_toward(velocity.x, target_speed, accel * delta)
	
	if abs(velocity.x) > SPEED * 0.03:
		$Sprite.scale.x = sign(velocity.x)

	move_and_slide()
	
func cheese_jump():
	velocity.y = JUMP_VELOCITY

func die():
	#get_tree().change_scene_to_packed(get_tree().current_scene)
	get_tree().reload_current_scene()

func _on_hazard_body_entered(body):
	# Player dies.
	die()
