extends CharacterBody2D

const UP_DIRECTION = Vector2.UP

# Geschwindigkeit
@export var speed = 250.0


@export var jump_strength = -600.0
@export var maximum_jumps = 2
@export var double_jump_strength = -400.0

# Schwerkraft
@export var gravity = 20.0

var _jumps_made = 0

# Bewegungsgeschwindigkeit (Bewegung)
var _motion = Vector2.ZERO

@onready var _sprite = get_node("CollisionShape2D/Sprite2D")
@onready var _animation = get_node("CollisionShape2D/Sprite2D/AnimationPlayer")
@onready var _notifier = get_node("Notifier")
@onready var _player = get_node(".")

func _physics_process(delta: float) -> void:

	# Laufrichtung auslesen
	var _horizontal_direction = ( Input.get_action_strength("move_right") - Input.get_action_strength("move_left") )
	
	# Füße in Laufrichtung setzen
	if (_horizontal_direction < 0): _sprite.flip_h = true
	elif (_horizontal_direction > 0): _sprite.flip_h = false
	
	
	## Bewegung ist in X- (links, rechts) und Y-Achse (hoch, runter) aufgeteilt ##
	
	# Die Links/Rechts Bewegung ergibt sich aus der berechneten Laufrichtung * Geschwindigkeit
	_motion.x = _horizontal_direction * speed
	
	# Die Hoch/Runter Bewegung entspricht einem Springen/Fallen und wird Real durch die Erdanziehungskraft/Schwerkraft
	# beeinflusst. Wir müssen dies nachbilden, durch den Wert in der Variablen "Gravity"
	_motion.y += gravity


	# Bewegung ausführen
	set_velocity(_motion)
	set_up_direction(UP_DIRECTION)
	move_and_slide()
	_motion = velocity
	
	
	
	## Spieler-Status ##
	
	# Wir müssen zu jeder Zeit wissen in welchem "Status" sich die Spielerfigur befindet.
	# Bewegt sie sich gerade, oder steht sie still, fällt sie gerade aus der Luft, oder springt sie hoch
	
	var is_falling = _motion.y > 0.0 and not is_on_floor()
	var is_jumping = Input.is_action_just_pressed("jump") and is_on_floor()	
	var is_double_jumping = Input.is_action_just_pressed("jump") and ( is_falling or not is_on_floor() )
	var is_jump_cancelled = Input.is_action_just_released("jump") and _motion.y < 0.0
	var is_jump_finished = is_on_floor() && _jumps_made > 0
	var is_idling = is_on_floor() and not is_zero_approx(_motion.x)
	var is_running = is_on_floor() and not is_zero_approx(_motion.x)
	
	
	## Statusabfrage ##
	# Wenn wir wissen in welchem Status sich die Spielerfigur gerade befindet, können wir entsprechend
	# dem Status die Bewegung für diesen Status umsetzen
	
#	if is_falling:
#		print("is_falling")
	
	# Spieler springt	
	if is_jumping:
		# Anzahl der Sprünge erhöhen
		_jumps_made += 1
		
		# Sprungstärke einstellen
		_motion.y = jump_strength
		
		#print("is_jumping: "+ str(_jumps_made))
		
	# Spiele führt Doppelsprung aus
	elif is_double_jumping:
		# Anzahl der Sprünge erhöhen
		_jumps_made += 1
		
		# Wenn die Anzahl der Sprünge nicht höher als die erlaubte Anzahl ist,
		# kann der Doppelsprung ausgeführt werden
		if _jumps_made <= maximum_jumps:
			
			# Sprungstärke für den Doppelsprung setzen
			_motion.y = double_jump_strength
			
			#print("is_double_jumping")

	elif is_jump_finished: 
		# Sprung ist beendet, Spieler berührt den Boden, Anzahl der ausgeführten Sprünge zurücksetzen
		_jumps_made = 0
		#print("is_jump_finished")

	elif is_running:
		_animation.play("Idle")
	else:
		_animation.play("RESET")

	# Führt die Bewegung aus und setzt die neue Geschwindigkeit, z.b. wg. Fallen bei Schwerkraft
	set_velocity(_motion)
	set_up_direction(UP_DIRECTION)
	move_and_slide()
	_motion = velocity

	#if not _notifier.is_on_screen():
		#print("player exited screen")
