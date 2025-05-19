extends Node2D

@export var shape:Shape
@export var line_width = 2
@export var center_size = 10
@export var rotation_speed = 1
@export var velocity = Vector2(10,10)
var screen_size

enum ColorIdx {
	Red = 0,
	Blue = 1,
	Yellow = 2,
	Center = 3
}

var Colors = [Color.RED, Color.BLUE, Color.YELLOW, Color.BLACK]

var seq = [ColorIdx.Red, ColorIdx.Red, ColorIdx.Blue, ColorIdx.Yellow, ColorIdx.Red, ColorIdx.Center]

enum Shape {
	Square,
	Hexagon,
	Octagon
}

func get_oct(size) -> PackedVector2Array:
	var vert = []
	for k in 8:
		# (x, y) = (r cos(t + k π/4), r sin(t + k π/4)) (r=size, t=starting angle)
		vert.push_back(Vector2(size*cos(k*PI/4),  size*sin(k*PI/4)))
	return vert
	
func get_hex(size) -> PackedVector2Array:
	var vert = []
	for k in 6:
		vert.push_back(Vector2(size*cos(k*PI/3),  size*sin(k*PI/3)))
	return vert
	
func get_squ(size) -> PackedVector2Array:
	var vert = []
	for k in 4:
		vert.push_back(Vector2(size*cos(k*PI/2),  size*sin(k*PI/2)))
	return vert
	
func get_points(shape, size) -> PackedVector2Array:
	if shape == Shape.Square:
		return get_squ(size)
	elif shape == Shape.Hexagon:
		return get_hex(size)
	else:  #shape == Shape.Octagon:
		return get_oct(size)

func _ready() -> void:
	screen_size = get_viewport().size
	position = screen_size/2
	pass
	
	
func _draw():
	var collision_shape = CollisionPolygon2D.new()
	var points
	var max_size = seq.size()*line_width+center_size
	
	for idx in seq.size():
		var size = max_size - idx*line_width
		var color = Colors[seq[idx]]
		points = get_points(shape, size)
		draw_polygon(points, [color])
	
	collision_shape.polygon = get_points(shape, max_size)
	self.add_child(collision_shape)  # Add it as a child

func _process(delta):
	rotation += delta*rotation_speed*0.1
	position += velocity * delta
	
func hit(hitcolor:ColorIdx):
	if hitcolor == seq[0]:
		seq.pop_front()
		if(seq.size() <= 1):
			die()
	else:
		seq.push_back(hitcolor)
		_draw()

func die():
	queue_free()
	
