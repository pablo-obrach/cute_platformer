extends CharacterBody2D
class_name Player

var air_jump = false
var just_wall_jumped = false
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var max_health = 2
var health = 0
var can_take_damage = true



@onready var animation_player = $AnimationPlayer
@onready var animation_player2 = $AnimationPlayer2
@onready var animation_player3 = $AnimationPlayer3
@onready var sprite_2d = $Sprite2D
@onready var sprite_2d2 = $Sprite2D2
@onready var sprite_2d3 = $Sprite2D3
@onready var coyote_jump_timer = $CoyoteJumpTimer
@onready var starting_position = global_position
@onready var jumpSFX: AudioStreamPlayer = $JumpSFX

@export var movement_data : PlayerMovementData
@export var attacking = false
@export var death = false

func _ready():
	health = max_health

func _process(_delta):
	if Input.is_action_just_pressed("attack"):
		attack()
	
	# if death:
	# 	animation_player.play("die")

func _physics_process(delta):
	handle_gravity(delta)
	handle_wall_jump()
	handle_jump()
	var direction = Input.get_axis("left", "right")
	handle_acceleration(direction,delta)
	run(direction)
	apply_friction(direction,delta)
	apply_air_resistence(direction,delta)
	update_animations(direction)
	var was_on_floor = is_on_floor()
	move_and_slide()
	var just_left_edge = was_on_floor and !is_on_floor() and velocity.y >= 0
	if just_left_edge:
		coyote_jump_timer.start()
	just_wall_jumped = false

	if position.y >= 300:
		global_position = starting_position


func update_animations(direction):
	if !attacking and !death:
		if is_on_floor():
			if direction == 0:
				animation_player.play("idle")
				sprite_2d2.visible = false
				sprite_2d3.visible = false

			elif Input.is_action_pressed("run"):	
				animation_player.play("run")
				sprite_2d2.visible = true
				animation_player2.play("run_dust")
				sprite_2d3.visible = false
			else:
				animation_player.play("walk")
				sprite_2d2.visible = false
				sprite_2d3.visible = false
		else:
			if velocity.y < 0:
				animation_player.play("jump")
				sprite_2d2.visible = false
				

func handle_gravity(delta):
	if not is_on_floor():
		velocity.y += gravity * movement_data.gravity_scale * delta

func handle_jump():

	if is_on_floor() or coyote_jump_timer.time_left > 0.0:
			if Input.is_action_just_pressed("jump"):
				air_jump = true
				velocity.y = movement_data.jump_velocity
				jumpSFX.play()

	if not is_on_floor():
		if Input.is_action_just_released("jump") and velocity.y < movement_data.jump_velocity / 2:
			velocity.y = movement_data.jump_velocity / 2
				
		if Input.is_action_just_pressed("jump") and air_jump and not just_wall_jumped:
			velocity.y = movement_data.jump_velocity * 0.8
			sprite_2d3.visible = true
			animation_player3.play("jump_dust")
			jumpSFX.play()
			air_jump = false
			

func handle_wall_jump():
	if not is_on_wall_only(): return
	
	var wall_normal = get_wall_normal()
	if Input.is_action_just_pressed("jump") and wall_normal:
		velocity.x = wall_normal.x * movement_data.speed * 0.2
		velocity.y = movement_data.jump_velocity
		just_wall_jumped = true

func run(direction):
	if is_on_floor():
		if direction != 0 and Input.is_action_pressed("run"):
			velocity.x = move_toward(velocity.x,direction * movement_data.speed_running, movement_data.acceleration)
			sprite_2d.flip_h = direction == -1
			if direction == -1:
				sprite_2d2.flip_h = true
				sprite_2d2.position.x = -9
			else:
				sprite_2d2.flip_h = false
				sprite_2d2.position.x = -24
				

func handle_acceleration(direction,delta):
	if direction != 0:
		velocity.x = move_toward(velocity.x,direction * movement_data.speed, movement_data.acceleration * delta)
		sprite_2d.flip_h = direction == -1
		if direction == -1:
			sprite_2d2.flip_h = true
			sprite_2d2.position.x = -9
		else:
			sprite_2d2.flip_h = false
			sprite_2d2.position.x = -24
		

func apply_friction(direction,delta):
	if direction == 0 and is_on_floor():
		velocity.x = move_toward(velocity.x, 0, movement_data.friction * delta)


func apply_air_resistence(direction,delta):
	if direction == 0 and not is_on_floor():
		velocity.x = move_toward(velocity.x, 0, movement_data.air_resitence * delta)

func attack():
	var overLapping_objects = $AttackArea.get_overlapping_areas()

	for area in overLapping_objects:
		if area.get_parent().is_in_group("Enemies"):
			area.get_parent().die()

	attacking = true
	animation_player.play("attack")


func take_damage(damage_amaount : int):
	if can_take_damage:
		iFrames()
		health -= damage_amaount
		if health <= 0:
			death = true
			if death:
				animation_player.play("die")
			
			# starting_point()

		

func iFrames():
	can_take_damage = false
	await get_tree().create_timer(1).timeout
	can_take_damage = true



func _on_hazard_detector_area_entered(_area:Area2D):
	global_position = starting_position

func starting_point():
		death = false
		global_position = starting_position
		health = max_health



