extends Node2D

var target_value : int = 0

signal value_changed

@export var n1000 : int = 0
@export var n100 : int = 0
@export var n10 : int = 0
@export var n1 : int = 0


func _ready() -> void:
	change_target_value()


func change_target_value() -> void:
	var digits = []
	if target_value < 1000:
		digits.append(0)
		if target_value < 100:
			digits.append(0)
			if target_value < 10:
				digits.append(0)
				
	for character in str(target_value):
		digits.append(int(character))
	print(digits)
	n1000 = digits[0]
	n100 = digits[1]
	n10 = digits[2]
	n1 = digits[3]
	emit_signal("value_changed")


func _on_timer_timeout() -> void:
	target_value += 1
	change_target_value()
