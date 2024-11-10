extends CharacterBody2D

const H_ACCEL = 256 * 16
const SPEED = 256.0 * 6
const JUMP_VELOCITY = -2000.0

@onready var camera = %Camera2D
@onready var death_y = get_tree().get_nodes_in_group("DeathY")

@onready var sprite = $Sprite
@onready var item_pickup = $ItemPickup

# Linear jump.
var jump_timer = 0.0
const JUMP_TIMER_MAX = 0.3
const JUMP_MIN_LENGTH = 0.05

var current_held_item = null

func get_current_direction():
	# Unless we need to track it separately, this should work.
	return sprite.scale.x

func update_item(delta):
	if current_held_item != null:
		current_held_item.global_position = global_position + Vector2(64, 0) * get_current_direction()
		
		if not Input.is_action_pressed("player_grab"):
			current_held_item.global_position = global_position + Vector2(256 * 0.75, 0) * get_current_direction()
			current_held_item.release(get_current_direction())
			current_held_item = null
			Sounds.release.play()
	elif Input.is_action_pressed("player_grab"):
		var items = item_pickup.get_overlapping_bodies()
		for item in items:
			if item.pickup():
				current_held_item = item
				Sounds.grab.play()

func _physics_process(delta):
	# Jump is canceled as soon as we let go of the button.
	# WE have a minimum jump length though.
	if not Input.is_action_pressed("player_jump"):
		if jump_timer <= JUMP_TIMER_MAX - JUMP_MIN_LENGTH:
			jump_timer = 0.0
	# While the jump timer is active, we have a linear jump.
	if jump_timer > 0.0:
		velocity.y = JUMP_VELOCITY
		if jump_timer > JUMP_TIMER_MAX - JUMP_MIN_LENGTH:
			velocity.y *= 1.2
		jump_timer -= delta
	# Otherwise, add the gravity.
	elif not is_on_floor():
		velocity += get_gravity() * delta

	# Start the jump when the action is just pressed.
	if Input.is_action_just_pressed("player_jump") and is_on_floor():
		Sounds.jump_normal.play()
		jump()

	# Horizontal acceleration
	var direction = Input.get_axis("player_left", "player_right")
	var target_speed = direction * SPEED
	var accel = H_ACCEL
	if sign(velocity.x) != sign(target_speed):
		accel *= 2
	#elif abs(velocity.x) < (target_speed * 0.6):
		#accel *= 4
	velocity.x = move_toward(velocity.x, target_speed, accel * delta)
	
	if abs(velocity.x) > SPEED * 0.03:
		sprite.scale.x = sign(velocity.x)

	move_and_slide()
	update_item(delta)
	
	for death_y_node in death_y:
		if global_position.y > death_y_node.global_position.y:
			die()
			
	if Input.is_action_just_pressed("player_restart"):
		die()
	
	camera.go(delta)
	
func jump():
	jump_timer = JUMP_TIMER_MAX
	# The initial jump should "jolt" up.
	velocity.y = JUMP_VELOCITY * 1.2
	
func cheese_jump():
	jump()

func die():
	# TODO: Make this more efficient.
	var scene = load(get_tree().current_scene.scene_file_path)
	SceneTransition.change_to(scene)

func _on_hazard_body_entered(body):
	# Player dies.
	die()
