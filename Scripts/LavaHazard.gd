extends Node2D

@onready var animation_player = $AnimationPlayer


func _process(_delta):
	animation_player.play("Lava")



