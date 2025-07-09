extends Node2D
const max_flame_forward = 9
const max_flame_backward = 2
const range = max_flame_forward - max_flame_backward
@export var flame_speed = 2
@export_range(0, 1) var force = 0.3	
var force_target = 0
var rotation_target = 0
@export var rotation_speed = PI*2

func _ready():
	# Define the new vertices for the polygon
	var jet_outline = [
		Vector2(4, 3),
		Vector2(3, 5),
		Vector2(0, 6),
		Vector2(-1, 7),
		Vector2(-3, 10),
		Vector2(20, 09),
		Vector2(23, 0),
		Vector2(20, -9),
		Vector2(-3, -10),
		Vector2(-1, -7),
		Vector2(0, -6),
		Vector2(3, -5),
		Vector2(4, -3),
	]
	# Set the polygon's vertices
	self.polygon = jet_outline
	#print(force_target)
	force_target = force
	rotation_target = rotation
	
	$Flame.position.x = max_flame_forward - (force * range)
	
	#debug code
	#position =  get_viewport().size/2
	#set_force(0)
	
func _process(delta):
	if force != force_target:
		var step = delta * flame_speed
		force = move_toward(force, force_target, step)
		#0...1 range to position
		$Flame.position.x = max_flame_forward - (force * range)
		
	if global_rotation != rotation_target:
		var rotation_step = delta * rotation_speed
		global_rotation = rotate_toward(global_rotation, rotation_target, rotation_step)
		
func set_force(target):
	target = clamp(target, 0, 1)
	force_target = target
	
func set_rotation_target(target):
	rotation_target = target
