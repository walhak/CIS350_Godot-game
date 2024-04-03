extends CharacterBody2D

#max speed character moves at
@export var speed = 550

#how high the character jumps
@export var jump_power = -2000

#how fast the character gets to max speed
@export var accleration = 50

#how fast the character slows with no input being done
@export var friction = 70

#how fast the character falls to the "floor"
@export var gravity = 120

#number of times the character can jump
@export var max_jumps = 1

#currently how many jumps the character did
var current_jumps = 0

var level_tracker = 0

var current_level = ["res://Levels/Level_1/Map1.tscn", "res://Levels/Level_2/Map2.tscn", "res://Menu/menu.tscn"]

var check = false

#main update to allow movement
func _physics_process(delta):
	var input_dir: Vector2 = input()
	
	if Input.is_action_just_pressed("exitGame"):
		get_tree().quit()
	
	if Input.is_action_just_pressed("move_down") and check == true:
		get_tree().change_scene_to_file(current_level[level_tracker+1])
		level_tracker = level_tracker + 1
		
		
	if Input.is_action_just_pressed("resetButton"):
		get_tree().change_scene_to_file(current_level[level_tracker])
		
	if input_dir != Vector2.ZERO:
		acclerate(input_dir)
	else:
		add_friction()
	
	player_movement()
	jump()
	
#gets the user input and returns the user input
func input() -> Vector2:
	var input_dir = Vector2.ZERO
	input_dir.x = Input.get_axis("move_left", "move_right")	#left input gives '-1' and right input give '1'
	input_dir = input_dir.normalized()
	return input_dir
	
#what speeds up character/character movement
func acclerate(direction):
	#direction is left or right on what
	#speed is the rate of movement
	#accleration is how fast til max speed
	velocity = velocity.move_toward(speed * direction, accleration)
	
#slow down
func add_friction():
	velocity = velocity.move_toward(Vector2.ZERO, friction)
	
#update character movement to match what is being inacted
func player_movement(): 
	move_and_slide()
	
#how the character jumps if it didn't use all it's jumps
func jump():
	if Input.is_action_just_pressed("move_up"):
		if current_jumps < max_jumps:
			current_jumps += 1
			velocity.y = jump_power
	else:
		velocity.y += gravity
	
#check if character is on ground floor to reset the number of jumper character can do
	if is_on_floor():
		current_jumps = 0
		
#how character moves to next level
func _on_area_2d_body_entered(body):
	if body == self:
		check = true


func _on_area_2d_body_exited(body):
	check = false
