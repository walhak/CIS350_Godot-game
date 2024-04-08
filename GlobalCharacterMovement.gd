extends CharacterBody2D

#max speed character moves at
@export var speed = 365

#how high the character jumps
@export var jump_power = -1350

#how fast the character gets to max speed
@export var accleration = 70

#how fast the character slows with no input being done
@export var friction = 90

#how fast the character falls to the "floor"
@export var gravity = 110

#number of times the character can jump
@export var max_jumps = 1

#currently how many jumps the character did
var current_jumps = 0

var rep_cur = ["M1", "M2", "menu"]
var current_level = ["res://Levels/Level_1/Map1.tscn", "res://Levels/Level_2/Map2.tscn", "res://Menu/menu.tscn"]

var check = false

#main update to allow movement
func _physics_process(delta):
	var input_dir: Vector2 = input()
	
	if get_tree().get_current_scene() != null:
		var current_scene_name = get_tree().get_current_scene().get_name()
		var index = rep_cur.find(current_scene_name)
		
		if Input.is_action_just_pressed("move_down") and check == true:
			current_scene_name = get_tree().get_current_scene().get_name()
			index = rep_cur.find(current_scene_name)
			var next_scene_path = current_level[index+1]
			get_tree().change_scene_to_file(next_scene_path)
			
		if Input.is_action_just_pressed("resetButton"):
			current_scene_name = get_tree().get_current_scene().get_name()
			index = rep_cur.find(current_scene_name)
			get_tree().change_scene_to_file(current_level[index])
	
	if Input.is_action_just_pressed("exitGame"):
		get_tree().quit()
		
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
