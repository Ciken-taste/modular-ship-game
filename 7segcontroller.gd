extends Node2D

@export var me_1000 : bool = false
@export var me_100 : bool = false
@export var me_10 : bool = false
@export var me_1 : bool = false

var target_value : int = 0

@onready var d1 := ($ColorRect as ColorRect)
@onready var d2 := ($ColorRect2 as ColorRect)
@onready var d3 := ($ColorRect3 as ColorRect)
@onready var d4 := ($ColorRect4 as ColorRect)
@onready var d5 := ($ColorRect5 as ColorRect)
@onready var d6 := ($ColorRect6 as ColorRect)
@onready var d7 := ($ColorRect7 as ColorRect)

const COLOR = 0xffaa00ff

var seg_list : Array = []

func _ready() -> void:
	seg_list = [d1, d2, d3, d4, d5, d6, d7]


func shutoff_segs():
	for segs in seg_list:
		segs.self_modulate = Color.hex(0xffffff30)



func display_numbers():
	shutoff_segs()
	if target_value == 1:
		seg_list[4].self_modulate = Color.hex(COLOR)
		seg_list[6].self_modulate = Color.hex(COLOR)
		
	elif target_value == 2:
		seg_list[0].self_modulate = Color.hex(COLOR)
		seg_list[4].self_modulate = Color.hex(COLOR)
		seg_list[1].self_modulate = Color.hex(COLOR)
		seg_list[5].self_modulate = Color.hex(COLOR)
		seg_list[2].self_modulate = Color.hex(COLOR)
	
	elif target_value == 3:
		seg_list[0].self_modulate = Color.hex(COLOR)
		seg_list[4].self_modulate = Color.hex(COLOR)
		seg_list[1].self_modulate = Color.hex(COLOR)
		seg_list[6].self_modulate = Color.hex(COLOR)
		seg_list[2].self_modulate = Color.hex(COLOR)
	
	elif target_value == 4:
		seg_list[3].self_modulate = Color.hex(COLOR)
		seg_list[4].self_modulate = Color.hex(COLOR)
		seg_list[1].self_modulate = Color.hex(COLOR)
		seg_list[6].self_modulate = Color.hex(COLOR)
	
	elif target_value == 5:
		seg_list[0].self_modulate = Color.hex(COLOR)
		seg_list[3].self_modulate = Color.hex(COLOR)
		seg_list[1].self_modulate = Color.hex(COLOR)
		seg_list[6].self_modulate = Color.hex(COLOR)
		seg_list[2].self_modulate = Color.hex(COLOR)
	
	elif target_value == 6:
		seg_list[0].self_modulate = Color.hex(COLOR)
		seg_list[3].self_modulate = Color.hex(COLOR)
		seg_list[1].self_modulate = Color.hex(COLOR)
		seg_list[5].self_modulate = Color.hex(COLOR)
		seg_list[6].self_modulate = Color.hex(COLOR)
		seg_list[2].self_modulate = Color.hex(COLOR)
	
	elif target_value == 7:
		seg_list[0].self_modulate = Color.hex(COLOR)
		seg_list[4].self_modulate = Color.hex(COLOR)
		seg_list[6].self_modulate = Color.hex(COLOR)
	
	elif target_value == 8:
		seg_list[0].self_modulate = Color.hex(COLOR)
		seg_list[3].self_modulate = Color.hex(COLOR)
		seg_list[1].self_modulate = Color.hex(COLOR)
		seg_list[5].self_modulate = Color.hex(COLOR)
		seg_list[6].self_modulate = Color.hex(COLOR)
		seg_list[2].self_modulate = Color.hex(COLOR)
		seg_list[4].self_modulate = Color.hex(COLOR)
	
	elif target_value == 9:
		seg_list[0].self_modulate = Color.hex(COLOR)
		seg_list[3].self_modulate = Color.hex(COLOR)
		seg_list[4].self_modulate = Color.hex(COLOR)
		seg_list[1].self_modulate = Color.hex(COLOR)
		seg_list[6].self_modulate = Color.hex(COLOR)
	
	elif target_value == 0:
		seg_list[0].self_modulate = Color.hex(COLOR)
		seg_list[3].self_modulate = Color.hex(COLOR)
		seg_list[4].self_modulate = Color.hex(COLOR)
		seg_list[5].self_modulate = Color.hex(COLOR)
		seg_list[6].self_modulate = Color.hex(COLOR)
		seg_list[2].self_modulate = Color.hex(COLOR)


func _on_master_value_changed() -> void:
	if me_1000:
		target_value = get_parent().n1000
	if me_100:
		target_value = get_parent().n100
	if me_10:
		target_value = get_parent().n10
	if me_1:
		target_value = get_parent().n1
	
	display_numbers()
