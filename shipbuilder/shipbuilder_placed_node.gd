extends Node2D

@export var texture_img : Texture
@export var pos : Vector2



func _ready() -> void:
	var button := ($TextureButton as TextureButton)
	button.texture_normal = texture_img


func _on_texture_button_pressed() -> void:
	get_parent().remove_block_coords = pos
	queue_free()
