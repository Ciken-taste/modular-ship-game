extends Control

@onready var confirm_save_button := ($ConfirmSave as Button)

@onready var camera = get_parent().get_parent()

func _physics_process(_delta: float) -> void:
	pass

func hidden(is_hidden : bool) -> void:
	if is_hidden:
		modulate.a = 0
		position = Vector2.ZERO
	else:
		modulate.a = 1
		global_position = camera.global_position


func _on_save_button_pressed() -> void:
	hidden(false)


func _on_line_edit_text_changed(new_text: String) -> void:
	if new_text != "":
		confirm_save_button.disabled = false
	else:
		confirm_save_button.disabled = true


func _on_cancelbutton_pressed() -> void:
	hidden(true)

func _on_confirm_save_pressed() -> void:
	hidden(true)
