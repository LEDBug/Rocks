extends Node2D

@export var shape = "SQUARE"
@export var line_width = 5
@export var size = 40

var color_square = Color.RED
var color_circle = Color.BLUE
var color_triangle = Color.YELLOW
@export var color_center = Color.BLACK

var triangle_outline = [
	Vector2(0, (2*sqrt(3)/3))*size/2,
	Vector2(-1, (-1*sqrt(3)/3))*size/2,
	Vector2(1, (-1*sqrt(3)/3))*size/2,
	Vector2(0, (2*sqrt(3)/3))*size/2
]

var screen_size
var shapes = ["SQUARE", "CIRCLE", "TRIANGLE"]

func _ready() -> void:
	screen_size = get_viewport().size
	position = screen_size/2
	pass
	
	
func _draw():
	var collision_shape
	if shape == "SQUARE":
		collision_shape = CollisionShape2D.new()
		draw_rect( Rect2(Vector2(-size/2,-size/2), Vector2(size,size)),color_square, false, line_width, true )
	elif shape == "CIRCLE":
		collision_shape = CollisionShape2D.new()
		draw_circle(Vector2.ZERO, size/2, color_circle, false, line_width, true)
	else: #shape == "TRIANGLE"
		collision_shape = CollisionPolygon2D.new()
		
		draw_polyline(triangle_outline, color_triangle, line_width, true)
	self.add_child(collision_shape)  # Add it as a child
