extends Node2D

@export var max_speed = 200 # fastest possible speed in any direction (pixels/sec).
@export var max_acceleration = 10 # How fast the player will change speed
@export var drift_to_zero = 0.05 #how quickly the player drifts to 0 elocity if no acceleration applied. 
@export var turn_speed = 0.05 # How fast the player will turn (rad/sec).
@export var wrap_border = 15
@export var acc_acceleration = 0.5 # how fast the acceleration can change
var acceleration = Vector2.ZERO # The player's movement vector.
var velocity = Vector2.ZERO

var screen_size

func _ready():
	
	# Define the new vertices for the polygon
	var turret_outline = [
		Vector2(-10, 20),
		Vector2(40, 0),
		Vector2(-10, -20),
		Vector2(5, 0)
	]
	# Set the polygon's vertices
	self.polygon = turret_outline
	screen_size = get_viewport().size
	position = screen_size/2

func _process(delta):
	move(delta)
	turn(delta)
	
func move(delta):
	var new_acceleration = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("move_right"):
		new_acceleration.x += 1
	if Input.is_action_pressed("move_left"):
		new_acceleration.x -= 1
	if Input.is_action_pressed("move_down"):
		new_acceleration.y += 1
	if Input.is_action_pressed("move_up"):
		new_acceleration.y -= 1
	
	var acc_target = new_acceleration.normalized() * max_acceleration
	acceleration.x = move_toward(acceleration.x, acc_target.x, acc_acceleration)
	acceleration.y = move_toward(acceleration.y, acc_target.y, acc_acceleration)
	
	if acceleration.length() > 0:
		var jetforce = acceleration.length()/max_acceleration
		
		set_jet_force(jetforce)
		set_jet_rotation(acceleration.angle())
		velocity += acceleration
	else:
		set_jet_force(0)
		velocity += (velocity * -drift_to_zero)
		
	if velocity.length() > max_speed:
		velocity = velocity.normalized()*max_speed
	
	position += velocity * delta
	 # Wrap-around logic: check if the object is out of bounds
	
	
	if position.x < -wrap_border:
		position.x = screen_size.x+wrap_border  # Wrap to the right side
	elif position.x > screen_size.x+wrap_border:
		position.x = -wrap_border  # Wrap to the left side

	if position.y < -wrap_border:
		position.y = screen_size.y+wrap_border  # Wrap to the bottom
	elif position.y > screen_size.y+wrap_border:
		position.y = -wrap_border  # Wrap to the top

func set_jet_force(force):
	#print("jet force: ", force)
	$Jet1.set_force(force)
	$Jet2.set_force(force)
	$Jet3.set_force(force)
	$Jet4.set_force(force)
	
func set_jet_rotation(angle):
	$Jet1.set_rotation_target(angle)
	$Jet2.set_rotation_target(angle)
	$Jet3.set_rotation_target(angle)
	$Jet4.set_rotation_target(angle)

func turn(delta):
	var target_rotation = velocity.angle()
	rotation = rotate_toward(rotation, target_rotation, turn_speed)
	
	
	
