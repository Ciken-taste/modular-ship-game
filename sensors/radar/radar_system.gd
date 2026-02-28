extends Node2D

@onready var dish := ($RadarDish as Node2D)
@onready var ray := ($RadarDish/RayCast2D as RayCast2D)

@onready var display := ($Display as Node2D)

@export var radar_size : float = 10000


@onready var scroll := ($Display/Scroll as Area2D)
@onready var sector_indicator := ($Display/Sector as Node2D)
var hovering_sector : bool = false
var sector_enabled : bool = false
var sector : float = 0.05
var sector_width : float = PI/2

var dish_speed : float = 0.01

func _ready() -> void:
	ray.target_position = Vector2(0, -radar_size)


func _physics_process(_delta: float) -> void:
	dish.rotation += dish_speed
	var x : int = 0
	while x < 10:
		x += 1
		var new_dot = preload("res://sensors/radar/range_dot.tscn").instantiate()
		new_dot.global_position = display.global_position - Vector2(sin(-dish.rotation), cos(-dish.rotation)) * 10 * x
		add_child(new_dot)
	

	if ray.is_colliding():
		# 1 = radar_size away
		var collision_pos : Vector2 = (ray.get_collision_point() - dish.global_position) / (radar_size / 10)
		print(collision_pos)
		var new_dot = preload("res://sensors/radar/radar_dot.tscn").instantiate()
		new_dot.global_position = display.global_position + collision_pos * 10
		add_child(new_dot)
	
	# [0, 2pi]

	
	if sector_enabled:
		if sector > 2*PI: sector = 0
		if sector < -2*PI: sector = 0
		var dish_angle : float = dish.rotation - floor(dish.rotation / (4*PI)) * 4 * PI
		dish_angle = remap(dish_angle, 0, 4*PI, -2*PI, 2*PI)
		if dish_angle > sector + sector_width:
			dish_speed = abs(dish_speed)
			dish_speed *= -1
		if dish_angle < sector:
			dish_speed = abs(dish_speed)


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		
		
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			if hovering_sector:
				sector -= 0.05
				scroll.rotation -= 0.05
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			if hovering_sector:
				sector += 0.05
				scroll.rotation += 0.05
		sector_indicator.rotation = sector


func _on_area_2d_mouse_entered() -> void:
	hovering_sector = true


func _on_area_2d_mouse_exited() -> void:
	hovering_sector = false


func _on_button_pressed() -> void:
	sector_enabled = not sector_enabled
	dish_speed = abs(dish_speed)
	if sector_enabled:
		sector_indicator.modulate = Color(1, 0, 0)
	else:
		sector_indicator.modulate = Color(0, 0, 0)


func _on_angle_slider_value_changed(value: float) -> void:
	sector_width = remap(value, 0, 100, PI/10, PI)
	($Display/Sector/ColorRect2 as ColorRect).rotation = sector_width - PI/2



func _on_speed_slider_value_changed(value: float) -> void:
	var dish_rot = dish_speed / abs(dish_speed)
	dish_speed = value * dish_rot
