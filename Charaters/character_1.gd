extends CharacterBody2D

@export var speed = 550
@export var jump_power = -2000

@export var accleration = 50
@export var friction = 70

@export var gravity = 120

@export var max_jumps = 1
var current_jumps = 0

func _physics_process(delta):#main update to allow movement
	var input_dir: Vector2 = input()
	
	if input_dir != Vector2.ZERO:
		acclerate(input_dir)
	else:
		add_friction()
	
	player_movement()
	jump()
	
func input() -> Vector2:
	var input_dir = Vector2.ZERO
	
	input_dir.x = Input.get_axis("move_left", "move_right")	#left input gives '-1' and right input give '1'
	input_dir = input_dir.normalized()
	return input_dir
	
func acclerate(direction):#speed up
	#direction is left or right on what
	#speed is the rate of movement
	#accleration is 
	velocity = velocity.move_toward(speed * direction, accleration)
	
func add_friction():#slow down
	velocity = velocity.move_toward(Vector2.ZERO, friction)
	
func player_movement(): 
	move_and_slide()
	
func jump():
	if Input.is_action_just_pressed("move_up"):
		if current_jumps < max_jumps:
			current_jumps += 1
			velocity.y = jump_power
	else:
		velocity.y += gravity
	
	if is_on_floor():
		current_jumps = 0


func _on_area_2d_body_entered(body):
	if body == self:
		print("Should be on next level")
		get_tree().change_scene_to_file("res://Menu/menu.tscn")

