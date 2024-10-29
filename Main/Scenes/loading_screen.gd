extends Node2D

@onready var loading_screen = preload("res://Main/Scenes/loading_screen.tscn")
var scene_to_load_path
var load_instance
var loading = false

func load_path(path):
	var curr_scene = get_tree().current_scene
	load_instance = loading_screen.instantiate()
	get_tree().root.add_child(load_instance)
	if ResourceLoader.has_cached(path):
		ResourceLoader.load_threaded_get(path)
	else:
		ResourceLoader.load_threaded_request(path)
		
	curr_scene.queue_free()
	loading = true
	scene_to_load_path = path
	
func _process(delta: float) -> void:
	if not loading:
		return
	var progress = []
	var status = ResourceLoader.load_threaded_get_status(scene_to_load_path,progress)
	if status == ResourceLoader.THREAD_LOAD_IN_PROGRESS:
		$ProgressBar.value= progress[0]*100
	elif status == ResourceLoader.THREAD_LOAD_LOADED:
		get_tree().change_scene_to_packed(ResourceLoader.load_threaded_get(scene_to_load_path))
		load_instance.queue_free()
		
	else:
		print('F')
