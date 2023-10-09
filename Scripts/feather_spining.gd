extends Node2D

@onready var feather_spinning = $AnimationPlayer
@onready var featherSFX : AudioStreamPlayer = $CoinSFX

func _process(_delta):
	feather_spinning.play("feather_spinning")



func player_area_entered(_area):
	GameManagement.gain_feather(1)
	queue_free()

