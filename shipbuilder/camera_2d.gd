extends Camera2D

const SPEED : int = 10

var movement_vector : Vector2 = Vector2.ZERO

var zoom_dir : int = 0

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_up"): movement_vector.y = -1
	if event.is_action_pressed("ui_down"): movement_vector.y = 1
	if event.is_action_pressed("ui_right"): movement_vector.x = 1
	if event.is_action_pressed("ui_left"): movement_vector.x = -1
	
	if event.is_action_released("ui_up"): movement_vector.y = 0
	if event.is_action_released("ui_down"): movement_vector.y = 0
	if event.is_action_released("ui_right"): movement_vector.x = 0
	if event.is_action_released("ui_left"): movement_vector.x = 0
	
	if event.is_action_pressed("zoom_in"): zoom_dir = 1
	if event.is_action_pressed("zoom_out"): zoom_dir = -1
	if event.is_action_released("zoom_in"): zoom_dir = 0
	if event.is_action_released("zoom_out"): zoom_dir = 0

func _physics_process(_delta: float) -> void:
	position += movement_vector * SPEED
	zoom += Vector2.ONE * zoom_dir * 0.05
