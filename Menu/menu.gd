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
