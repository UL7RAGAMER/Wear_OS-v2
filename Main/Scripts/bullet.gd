extends Area3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	global_position = $"../../Marker3D/Marker2D".global_position

	await get_tree().create_timer(1).timeout
	queue_free()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	look_at($"../../Marker3D/Marker3D".global_position)
	position+= transform.basis * Vector3(0,0,-150) * delta

	pass
