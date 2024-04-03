"""extends "res://addons/gut/test.gd"

class_name CharacterTest

func test_character_movement():
	# Load the scene containing the character
	var character_scene = load("res://Levels/Level_1/Map1.tscn")
	var character_instance = character_scene.instance()

	# Add the character to the test scene
	add_child(character_instance)

	# Set initial variables
	character_instance.speed = 550
	character_instance.accleration = 50
	character_instance.friction = 70
	character_instance.gravity = 120

	# Simulate pressing movement keys
	character_instance.input_dir = Vector2(1, 0)  # Simulate pressing right arrow key
	character_instance._physics_process(0.1)  # Simulate a physics update

	# Assert that the character's velocity has been adjusted correctly
	var expected_velocity = Vector2(550, 0)  # Speed * direction
	assert_eq(expected_velocity, character_instance.velocity, 'Character should accelerate.')

	# Simulate releasing movement keys and applying friction
	character_instance.input_dir = Vector2.ZERO  # Simulate releasing all movement keys
	character_instance._physics_process(0.1)  # Simulate a physics update

	# Assert that the character's velocity has been slowed by friction
	var slowed_velocity = Vector2(480, 0)  # Velocity move toward Vector2.ZERO with friction
	assert_eq(slowed_velocity, character_instance.velocity, 'Character should slow down due to friction.')

	# Simulate jumping
	character_instance.input_dir = Vector2.ZERO
	character_instance.is_on_floor_value = true  # Simulate being on the floor
	character_instance._physics_process(0.1)  # Simulate a physics update
	character_instance.input_dir = Vector2(0, -1)  # Simulate pressing the jump key
	character_instance._physics_process(0.1)  # Simulate a physics update

	# Assert that the character's velocity has been adjusted for jumping
	var expected_jump_velocity = Vector2(480, -2000)  # Initial velocity + jump power
	assert_eq(expected_jump_velocity, character_instance.velocity, 'Character should jump.')

	# Clean up
	character_instance.queue_free()
"""
