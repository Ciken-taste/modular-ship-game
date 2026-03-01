extends Control

@onready var confirm_save_button := ($ConfirmSave as Button)


func hidden(is_hidden : bool) -> void:
	if is_hidden:
		modulate.a = 0
		position = Vector2.ZERO
	else:
		modulate.a = 1
		position = Vector2(-701.0, 186.0)

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
