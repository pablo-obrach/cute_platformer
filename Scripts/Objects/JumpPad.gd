extends Node2D

@export var force : float = -350
@onready var jump_pad = $JumpPadActive
@onready var jump_pad_SFX = $JumpPadSFX


func _on_area_2d_area_entered(area:Area2D):
	if area.get_parent() is Player:
		area.get_parent().velocity.y = force
		jump_pad.play("jump_pad_action")
		jump_pad_SFX.play()
