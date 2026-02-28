extends Control

@onready var new_game_menu := ($ChooseShip as Control)
@onready var ship_selector := ($ChooseShip/OptionButton as OptionButton)

@onready var vars = get_node("/root/global")

func _ready() -> void:
	get_saves()
	get_ships()


func get_saves() -> void:	
	var dir = DirAccess.open("user://saves/")
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			print("Found file: " + file_name)
			file_name = dir.get_next()
	else:
		dir = DirAccess.open("user://")
		dir.make_dir("saves")
		DirAccess.make_dir_absolute("user://saves")
		get_saves()


func get_ships() -> void:
	var dir = DirAccess.open("user://ships/")
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			print("Found file: " + file_name)
			ship_selector.add_item(file_name)
			file_name = dir.get_next()
	else:
		dir = DirAccess.open("user://")
		dir.make_dir("ships")
		DirAccess.make_dir_absolute("user://ships")
		get_ships()





func _on_new_pressed() -> void:
	new_game_menu.global_position = Vector2(200, 200)


func _on_load_pressed() -> void:
	pass # Replace with function body.


func _on_shipbuilder_pressed() -> void:
	get_tree().change_scene_to_file("res://shipbuilder/shipbuilder.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_close_new_pressed() -> void:
	new_game_menu.position = Vector2(200, 200) * -100


func _on_start_pressed() -> void:
	vars.selected_ship = ship_selector.get_item_text(ship_selector.selected)
	get_tree().change_scene_to_file("res://world.tscn")
