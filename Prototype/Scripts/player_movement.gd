extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animated_sprite = $AnimatedSprite2D

var facing_direction = 0

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		if facing_direction == -1:
			animated_sprite.play("player_jump_left")
		elif facing_direction == 1:
			animated_sprite.play("player_jump_right")
		else:
			animated_sprite.play("player_jump")

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if Input.is_action_pressed("move_left"):
		velocity.x = -SPEED
		animated_sprite.play("player_walk_left")
		facing_direction = -1
	elif Input.is_action_pressed("move_right"):
		velocity.x = SPEED
		animated_sprite.play("player_walk_right")
		facing_direction = 1
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		animated_sprite.play("player_idle")

	move_and_slide()
