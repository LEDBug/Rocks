extends Node2D
var screen_size
@export_range(0,50) var borderwidth: int = 20
var center_left = 0
var center_right = 0
var center_top = 0
var center_bottom = 0


func _draw():
	screen_size = get_viewport().size
	var boundbox
	if screen_size.x >= screen_size.y:
		
		var posx = (screen_size.x - screen_size.y + borderwidth)/2
		var posy = borderwidth/2
		boundbox = Rect2i(Vector2(posx,posy),Vector2(screen_size.y-borderwidth, screen_size.y-borderwidth))
		center_left = (screen_size.x - screen_size.y) /4
		center_right = screen_size.x - center_left
		center_bottom =  screen_size.y
	else:
		var posy = (screen_size.y - screen_size.x + borderwidth)/4
		var posx = borderwidth/2
		boundbox = Rect2i(Vector2(posx,posy),Vector2(screen_size.x-borderwidth, screen_size.x-borderwidth)) 
		center_top = (screen_size.y - screen_size.x)
		center_bottom = screen_size.y - center_top
		center_right = screen_size.y
	draw_rect(boundbox, Color.BLACK, false, borderwidth)
	draw_circle(Vector2(center_left,screen_size.y/2),5, Color.GREEN)
	draw_circle(Vector2(center_right,screen_size.y/2),5, Color.GREEN)
	draw_circle(Vector2(screen_size.x/2,center_top),5, Color.GREEN)
	draw_circle(Vector2(screen_size.x/2,center_bottom),5, Color.GREEN)
	
	
	
	
