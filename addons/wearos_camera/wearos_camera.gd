@tool
extends EditorPlugin


func _enter_tree() -> void:
	add_custom_type("WearOS_Camera","Camera2D",preload("res://Main/Scripts/camera_2d.gd"),preload("res://Assets/2D/icon.svg"))
	# Initialization of the plugin goes here.
	pass


func _exit_tree() -> void:
	remove_custom_type("WearOS_Camera")
	# Clean-up of the plugin goes here.
	pass
