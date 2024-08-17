extends Node


func dim():
	if Engine.has_singleton("GodotAndroidPluginTemplate"):
		var plugin = Engine.get_singleton("GodotAndroidPluginTemplate")
		plugin.dimScreen()

func restore():
	if Engine.has_singleton("GodotAndroidPluginTemplate"):
		var plugin = Engine.get_singleton("GodotAndroidPluginTemplate")
		plugin.restoreScreenBrightness()

func idle():
	if Engine.has_singleton("GodotAndroidPluginTemplate"):
		var plugin = Engine.get_singleton("GodotAndroidPluginTemplate")
		plugin.setIdlePowerMode()
