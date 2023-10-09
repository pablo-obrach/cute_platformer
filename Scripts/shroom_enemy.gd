extends CharacterBody2D


@export var speed = -60.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var facing_right: bool = false
var death = false
@onready var hittedEnemy: AudioStreamPlayer = $HittedEnemy

func _ready():
	$AnimationPlayer.play("shroom_run")

func _physics_process(delta):

	if not is_on_floor():
		velocity.y += gravity * delta
	
	found_edge()
	found_wall_left()
	found_wall_right()

	velocity.x = speed
	move_and_slide()




func flip_right():
	facing_right = !facing_right
	scale.x = abs(scale.x) * -1

	if facing_right:
		speed = abs(speed)
	else:
		speed = abs(speed) * -1

func found_edge():
	if !$RayCast2D.is_colliding() and is_on_floor():
		flip_right()

func found_wall_left():
	if $RayCast2D2.is_colliding() and is_on_floor():
		flip_right()

func found_wall_right():
	if $RayCast2D3.is_colliding() and is_on_floor():
		flip_right()

func _on_shroom_hit_box_area_entered(area:Area2D):

	if area.get_parent() is Player and not death:
		area.get_parent().take_damage(1)

func die():
	death = true
	speed = 0
	$AnimationPlayer.play("shroom_hit")
	hittedEnemy.play()
