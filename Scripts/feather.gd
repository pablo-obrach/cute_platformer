extends Node2D

@onready var feather_collectible = $AnimationPlayer

func _process(_delta):
	feather_collectible.play("feather")
