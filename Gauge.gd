extends Control

@onready var slider := ($HSlider as HSlider)
@onready var gauge := ($Needle as Node2D)

@export var variable_shake : float = 0

var kp = 0.1
var ki = 0.5

var prev_error = 0
var integral = 0

var timer = 0

func _physics_process(delta: float) -> void:
	timer += variable_shake
	if randf() > 0.9:
		variable_shake *= -1
	var shake_error = (sin(timer) * 2 * cos(2 * timer)) * 0.05
	
	
	# slider.value = 0 then gauge.rotation = -PI/2
	# slider.value = 100 then gauge.rotation = PI/2
	var targer_rot : float = remap(slider.value, 0, 100, -PI/2.3, PI/2.3) + shake_error
	var error = gauge.rotation - targer_rot
	var proportional = error
	integral = integral + error * delta
	gauge.rotation -= kp * proportional + ki * integral 
	prev_error = error
	gauge.rotation = clamp(gauge.rotation, -PI/2, PI/2)
