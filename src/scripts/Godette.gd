extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -600.0
const DOUBLE_JUMP_VELOCITY = -400.0
const MAX_JUMPS = 2

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var godette = $Godette
@onready var animated_sprite = $AnimatedSprite2D

var _jumps_made = 0

func _physics_process(delta):	
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		animated_sprite.animation = "jump"
	else:
		if (velocity.x == 0):
			animated_sprite.animation = "idle"
		else: 
			animated_sprite.animation = "run"

	animated_sprite.play()

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept"):
		if is_on_floor():
			_jumps_made += 1
			velocity.y = JUMP_VELOCITY
			
			print("jump: " + str(_jumps_made))
		else:
			if (_jumps_made < MAX_JUMPS):
				_jumps_made += 1
				velocity.y = DOUBLE_JUMP_VELOCITY
								
				print("double jump: " + str(_jumps_made))
	
	elif is_on_floor() && _jumps_made > 0:
		_jumps_made = 0
		
		print("back on floor: "+ str(_jumps_made))
		

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		if (velocity.x < 0):
			animated_sprite.flip_h = true
		else:
			animated_sprite.flip_h = false
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
