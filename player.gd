extends Node2D

@onready var vars = get_node("/root/global")
@onready var camera := ($Camera2D as Camera2D)
var player_ship : Array = []

func _ready() -> void:
	var save_file = FileAccess.open("user://ships/" + vars.selected_ship, FileAccess.READ)
	while save_file.get_position() < save_file.get_length():
		var json_string = save_file.get_line()
		var json = JSON.new()
		var parse_result = json.parse(json_string)
		if not parse_result == OK:
			print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
			continue
		player_ship = json.data["ship"]
		spawn_ship(player_ship)


func spawn_ship(ship : Array) -> void:
	var x : int = 0
	while x < len(ship):
		var y : int = 0
		while y < len(ship):
			if ship[x][y] != "0":
				var new_hull = load("res://shippartscenes/"+ ship[x][y] +".tscn").instantiate()
				new_hull.position = Vector2(x, y) * 100
				add_child(new_hull)
				if ship[x][y] == "cockpit":
					camera.position = Vector2(x, y) * 100
					
			y += 1
		x += 1
