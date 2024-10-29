extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("left"):
		$Circle/Label.text = "left"
		
	elif Input.is_action_just_pressed("right"):
		$Circle/Label.text = "right"
		
	else:
		$Circle/Label.text = "none"
		
	pass
func _input(event: InputEvent) -> void:
	$Circle/Label2.text = str(event)
	InputEventScreenDrag
