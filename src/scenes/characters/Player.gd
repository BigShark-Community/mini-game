extends KinematicBody2D

const UP_DIRECTION = Vector2.UP

# Geschwindigkeit
export var speed = 300.0

export var jump_strength = -700.0
export var maximum_jumps = 2
export var double_jump_strength = -900.0

# Schwerkraft
export var gravity = 20.0

var _jumps_made = 0

# Bewegungsgeschwindigkeit (Bewegung)
var _motion = Vector2.ZERO


func _physics_process(delta: float) -> void:
	# Schwerkraft beinflusst die Geschwindigkeit (hoch/runter), damit der Spieler nicht in der Luft hängt
	#_motion.y += gravity
	
	# Bewegung links/rechts
	
	# Wenn die Taste für Rechts gedrück ist,
#	if Input.is_action_pressed("move_right"):
#		# dann die Bewegungsgeschwindigkeit auf der X-Achse auf die vorgegebene Geschwindigkeit setzen (+300)
#		_motion.x = speed
#
#	# Wenn die Taste für Links gedrück ist,
#	elif Input.is_action_pressed("move_left"):
#		# dann die Bewegungsgeschwindigkeit auf der X-Achse auf die vorgegebene Geschwindigkeit setzen, aber diesmal als negativer Wert (-300)
#		_motion.x = -speed

# Wenn keine Taste gedrückt ist, dann die Beweungsgeschwindigkeit zurücksetzen auf 0, andernfalls bewegt sich der Spieler in die gleiche Richtung weiter!!
#	else:
#		_motion.x = 0

	var _horizontal_direction = (
		Input.get_action_strength("move_right")
		- Input.get_action_strength("move_left")
	)
	
	_motion.x = _horizontal_direction * speed
	_motion.y += gravity

	_motion = move_and_slide(_motion, UP_DIRECTION)	
	
	
	
	# Spieler-Status
	var is_falling = _motion.y > 0.0 and not is_on_floor()
	var is_jumping = Input.is_action_just_pressed("jump") and is_on_floor()		
	var is_double_jumping = Input.is_action_just_pressed("jump") and is_falling
	var is_jump_cancelled = Input.is_action_just_released("jump") and _motion.y < 0.0
	var is_jump_finished = is_on_floor() && _jumps_made > 0
	var is_idling = is_on_floor() and not is_zero_approx(_motion.x)
	var is_running = is_on_floor() and not is_zero_approx(_motion.x)

	
	# Statusabfrage
	
	# Spieler springt
	if is_jumping:
		# Anzahl der Sprünge erhöhen
		_jumps_made += 1
		
		# Sprungstärke einstellen
		_motion.y = jump_strength
		
		print("is_jumping: "+ str(_jumps_made))
		
	# Spiele führt Doppelsprung aus
	elif is_double_jumping:
		# Anzahl der Sprünge erhöhen
		_jumps_made += 1
		
		# Wenn die Anzahl der Sprünge nicht höher als die erlaubte Anzahl ist,
		# kann der Doppelsprung ausgeführt werden
		if _jumps_made <= maximum_jumps:
			
			# Sprungstärke für den Doppelsprung setzen
			_motion.y = double_jump_strength
			
			print("is_double_jumping")
			
	elif is_jump_finished: 
		# Sprung ist beendet, Spieler berührt den Boden, Anzahl der ausgeführten Sprünge zurücksetzen
		_jumps_made = 0
		print("is_jump_finished")
		
#	
	# Führt die Bewegung aus und setzt die neue Geschwindigkeit, z.b. wg. Fallen bei Schwerkraft	
	_motion = move_and_slide(_motion, UP_DIRECTION)
