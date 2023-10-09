extends StaticBody2D

@onready var animated_block: AnimationPlayer = $BlockFadeOut
@onready var starting_position = global_position

func _on_area_2d_area_entered(area:Area2D):
	if area.get_parent() is Player:
		animated_block.play("platform_destroy")

func respawn_block():
	global_position = starting_position
	queue_free()
		
		
