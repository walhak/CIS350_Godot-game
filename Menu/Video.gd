extends TabBar

func _on_full_screen_toggled(toggled_on):
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		#Persistence.config.set_value("Video", "fullscreen", DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		#Persistence.config.set_value("Video", "fullscreen", DisplayServer.WINDOW_MODE_WINDOWED)


func _on_borderless_toggled(toggled_on):
	DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, toggled_on)
	#Persistence.config.set_value("Video", "borderless", toggled_on)
	#Persistence.save_data()


func _on_v_sync_item_selected(index):
	DisplayServer.window_set_vsync_mode(index)
	#Persistence.config.set_value("Video", "vsync", index)
	#Persistence.save_data()

