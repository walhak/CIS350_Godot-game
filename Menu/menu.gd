extends Control

func _on_play_pressed():
	get_tree().change_scene_to_file("res://Levels/Level_1/Map1.tscn")

func _on_options_pressed():
	get_tree().change_scene_to_file("res://Menu/settings.tscn")

func _on_quit_pressed():
	get_tree().quit()
