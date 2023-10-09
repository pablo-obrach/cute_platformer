extends Node2D

@onready var animated_heart = $AnimatedHeart

func _ready():
	animated_heart.play("heart_shrink")

func _on_area_2d_area_entered(area:Area2D):
	if area.get_parent() is Player:
		area.get_parent().max_health += 1
		area.get_parent().health += 1
		queue_free()