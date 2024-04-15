extends Camera2D

var map_width: int = 1200  # Adjust to your actual map width
var map_height: int = 670  # Adjust to your actual map height

func _ready():
	update_camera_limits()
	# Make sure to correct the connect call with a Callable for Godot 4.0
	get_viewport().connect("size_changed", Callable(self, "update_camera_limits"))

func update_camera_limits():
	var viewport_size = get_viewport_rect().size


	# Calculate zoom factors for both width and height
	var zoom_factor_x = (viewport_size.x / map_width) - 2
	var zoom_factor_y = viewport_size.y / map_height

	# Choose the larger zoom factor to ensure the map covers the entire viewport
	var zoom_factor = max(zoom_factor_x, zoom_factor_y)

	# Set the zoom
	zoom = Vector2(zoom_factor, zoom_factor)

	# Calculate new limits based on the zoom
	var adjusted_width = map_width * zoom_factor
	var adjusted_height = map_height * zoom_factor

	# Update the camera limits to the size of the map, centered
	limit_left = int((viewport_size.x - adjusted_width) / 2 / zoom_factor)
	limit_top = int((viewport_size.y - adjusted_height) / 2 / zoom_factor)
	limit_right = limit_left + map_width
	limit_bottom = limit_top + map_height
