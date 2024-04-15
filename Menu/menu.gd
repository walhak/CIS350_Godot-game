extends Control

#(play) button moves player to first level
func _on_play_pressed():
	get_tree().change_scene_to_file("res://Levels/Level_1/Map1.tscn")

#(option) button moves player to settings screen
func _on_options_pressed():
	get_tree().change_scene_to_file("res://Menu/settings.tscn")

#(quit) button allows player to leave game
func _on_quit_pressed():
	get_tree().quit()



# This function can be called to toggle between full-screen and windowed mode
func _on_full_screen_pressed():
	var window_mode = DisplayServer.window_get_mode()
	if window_mode == DisplayServer.WINDOW_MODE_FULLSCREEN:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)




func _on_pressed():
	var window_mode = DisplayServer.window_get_mode()
	if window_mode == DisplayServer.WINDOW_MODE_FULLSCREEN:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)


func _on_back_to_menu_pressed():
	get_tree().change_scene_to_file("res://Menu/menu.tscn")
