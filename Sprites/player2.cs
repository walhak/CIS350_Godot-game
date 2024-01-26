using Godot;
using System;

public class Player : KinematicBody2D
{
	// Player properties
	private float speed = 200; // Movement speed
	private Vector2 velocity = new Vector2(); // Player's current velocity
	private float gravity = 800; // Gravity affecting the player
	private float jumpForce = -400; // Force applied when jumping
	private bool isJumping = false; // Flag to track if the player is currently jumping
	private int maxHealth = 100; // Maximum health of the player
	private int currentHealth; // Current health of the player

	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(float delta)
	{
		// Update player logic here
		ProcessInput();
		UpdateMovement(delta);
	}

	private void ProcessInput()
	{
		// Handle player input
		velocity = new Vector2(); // Reset velocity

		if (Input.IsActionPressed("ui_right"))
		{
			velocity.x += speed; // Move right
		}

		if (Input.IsActionPressed("ui_left"))
		{
			velocity.x -= speed; // Move left
		}

		if (IsOnFloor() && Input.IsActionJustPressed("ui_up"))
		{
			// Jump only when on the ground
			velocity.y = jumpForce;
			isJumping = true;
		}
	}

	private void UpdateMovement(float delta)
	{
		// Apply gravity
		velocity.y += gravity * delta;

		// Move the player
		velocity = MoveAndSlide(velocity, new Vector2(0, -1));

		// Check if the player is on the ground after jumping
		if (IsOnFloor() && isJumping)
		{
			isJumping = false;
		}
	}

	// Handle player taking damage
	public void TakeDamage(int damage)
	{
		currentHealth -= damage;
		if (currentHealth <= 0)
		{
			Die();
		}
	}

	// Handle player's death
	private void Die()
	{
		// Perform actions when the player dies
		QueueFree(); // Destroy the player instance (you may want to handle this differently in your game)
	}

	// Initialize player properties
	public override void _Ready()
	{
		currentHealth = maxHealth;
	}
}
