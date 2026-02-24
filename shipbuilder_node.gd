extends Node2D

@export var remove_self : bool = false
@export var pos : Vector2
@export var texture_img : Texture 
@onready var sprite := ($Sprite2D as TextureButton)


func _physics_process(_delta: float) -> void:
	if remove_self: queue_free()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite.texture_normal = texture_img

func _on_sprite_2d_pressed() -> void:
	get_parent().get_parent().new_block_coords = pos
	queue_free()
