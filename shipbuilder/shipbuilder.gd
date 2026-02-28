extends Control

@onready var pgeneration_label := ($Camera2D/PowerGeneration as Label)
@onready var acceleration_label := ($Camera2D/MaxAcceleration as Label)
@onready var dv_label := ($Camera2D/Range as Label)
@onready var fuel_capacity_label := ($Camera2D/FuelCapacity as Label)
@onready var fuel_consumption_label := ($Camera2D/FuelConsumption as Label)

@onready var save_button := ($Camera2D/SaveButton as Button)
@onready var ship_name_input := ($Camera2D/SaveButton/Savemenu/LineEdit as LineEdit)


@export var new_block_coords : Vector2 = Vector2.ZERO
@export var remove_block_coords : Vector2 = Vector2.ZERO

@onready var ghost_block_tab := ($Ghostblocks as Node)

var is_valid : bool = false


# Block IDs
# "0" = empty; "hull"; "cockpit"; "generator"
var selected_block : String = "0"

var ship : Array = []

# Max size of the ship, smaller ships are cheaper and easier to maintain
var ship_size : int = 100

var power_generation : int = 0
var power_demand : int = 0
var max_acceleration : float = 0
var dv : float = 0
var fuel_capacity : float = 0
var fuel_consumption : float = 0

var cargo_size : int = 0



func _ready() -> void:
	var x : int = 0
	while x < ship_size:
		ship.append([])
		
		var y : int = 0
		while y < ship_size:
			ship[x].append("0")
			y += 1
		x += 1

	@warning_ignore("integer_division")
	ship[ship_size/2][ship_size/2] = "cockpit"

func save_ship():
	var save_file = FileAccess.open("user://ships/" + ship_name_input.text + ".save", FileAccess.WRITE)
	var json_string = JSON.stringify({"ship": ship})
	save_file.store_line(json_string)

func update_labels() -> void:
	pgeneration_label.text = "POWER GENERATION: " + str(power_generation) + "MW/" + str(power_demand) + "MW"
	acceleration_label.text = "MAX ACCELERATION: " + str(roundf(max_acceleration)) + " M/S^2"
	dv_label.text = "DV: " + str(roundf(dv)) + " M/S"
	fuel_capacity_label.text = "FUEL CAPACITY: " + str(fuel_capacity) + " L"
	fuel_consumption_label.text = "CONSUMPTION: " + str(fuel_consumption) + " L/S"
	

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == 2:
			selected_block = "0"
			draw_ghost_blocks()
		   


func _physics_process(_delta: float) -> void:
	if new_block_coords != Vector2.ZERO:
		ship[new_block_coords.x][new_block_coords.y] = selected_block
		var new_block = preload("res://shipbuilder/shipbuilder_placed_node.tscn").instantiate()
		new_block.texture_img = load("res://Sprites/shipparts/"+ selected_block +".png")
		new_block.position = new_block_coords * 50
		new_block.pos = new_block_coords
		add_child(new_block)
		new_block_coords = Vector2.ZERO
		draw_ghost_blocks()
	
	if remove_block_coords != Vector2.ZERO:
		ship[remove_block_coords.x][remove_block_coords.y] = "0"
		draw_ghost_blocks()
		remove_block_coords = Vector2.ZERO

func get_ship_stats():
	var mass : float = 0
	var force : float = 0
	power_generation = 0
	power_demand = 0
	max_acceleration = 0
	fuel_capacity = 0
	fuel_consumption = 0
	var x : int = 0
	while x < ship_size:
		var y : int = 0
		while y < ship_size:
			if ship[x][y] == "cockpit":
				mass += 25
				power_generation += 5
			
			if ship[x][y] == "hull":
				mass += 10
			if ship[x][y] == "generator": 
				power_generation += 20
				mass += 40
			if ship[x][y] == "thruster":
				power_demand += 15
				fuel_consumption += 8
				mass += 40
				force += 5000
			if ship[x][y] == "fueltank":
				fuel_capacity += 5000
				mass += 100
			
			
			y += 1
		x += 1
	max_acceleration = force / mass
	var fuel_time : float = fuel_capacity / fuel_consumption
	dv = max_acceleration * fuel_time
	acceleration_label.self_modulate = Color(1, 1, 1)
	fuel_capacity_label.self_modulate = Color(1, 1, 1)
	pgeneration_label.self_modulate = Color(1, 1, 1)
	is_valid = true
	if max_acceleration <= 0: 
		is_valid = false
		acceleration_label.self_modulate = Color(1, 0, 0)
	if fuel_capacity <= 0:
		fuel_capacity_label.self_modulate = Color(1, 0, 0)
		is_valid = false
	if power_demand > power_generation:
		is_valid = false
		pgeneration_label.self_modulate = Color(1, 0, 0)
	
	if is_valid: save_button.disabled = false
	else: save_button.disabled = true
	update_labels()



func draw_ghost_blocks() -> void:
	get_ship_stats()
	var kids = ghost_block_tab.get_children()
	var i : int = 0
	while i < len(kids):
		kids[i].remove_self = true
		i += 1
	var x : int = 0
	if selected_block == "0": return
	while x < ship_size:
		var y : int = 0
		while y < ship_size:
			if ship[x][y] != "0":
				var a : int = -1
				while a < 2:
					if ship[x + a][y] == "0":
						var ghost_block = preload("res://shipbuilder/shipbuilder_node.tscn").instantiate()
						ghost_block.texture_img = load("res://Sprites/shipparts/" + selected_block + ".png")
						ghost_block.pos = Vector2(x + a, y)
						ghost_block.position = Vector2(x + a, y) * 50
						ghost_block_tab.add_child(ghost_block)
					if ship[x][y + a] == "0":
						var ghost_block = preload("res://shipbuilder/shipbuilder_node.tscn").instantiate()
						ghost_block.texture_img = load("res://Sprites/shipparts/" + selected_block + ".png")
						ghost_block.pos = Vector2(x, y + a)
						ghost_block.position = Vector2(x, y + a) * 50
						ghost_block_tab.add_child(ghost_block)
					a += 1
					
				
			
			y += 1
		
		x += 1
		
	
	

func _on_hull_pressed() -> void:
	selected_block = "hull"
	draw_ghost_blocks()


func _on_button_pressed() -> void:
	selected_block = "generator"
	draw_ghost_blocks()


func _on_thruster_pressed() -> void:
	selected_block = "thruster"
	draw_ghost_blocks()


func _on_fueltank_pressed() -> void:
	selected_block = "fueltank"
	draw_ghost_blocks()


func _on_confirm_save_pressed() -> void:
	save_ship()


func _on_exit_button_pressed() -> void:
	get_tree().change_scene_to_file("res://mainmenu/main_menu.tscn")
