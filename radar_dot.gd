extends Node2D


func _physics_process(_delta: float) -> void:
	modulate.a -= 0.005



func _on_timer_timeout() -> void:
	queue_free()
