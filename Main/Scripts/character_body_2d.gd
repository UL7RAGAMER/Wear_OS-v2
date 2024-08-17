extends CharacterBody2D


const SPEED = 900.0
const JUMP_VELOCITY = -400.0
func _physics_process(delta: float) -> void:
	$"../Label".text = str(Engine.get_frames_per_second()) + " " + str(OS.get_name())


	
func chk_inside_cirle(r):
	return (round(position.y))**2 < (round(r))**2 - (round(position.x))**2
func _input(event: InputEvent) -> void:
		if event is InputEventScreenDrag:
			position = get_global_mouse_position()	
		move_and_slide()
