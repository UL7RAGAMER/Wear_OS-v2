extends Marker3D
var cur_pos = Vector3.ZERO
var last_pos = Vector3.ZERO
var o:Vector2
@onready var gun: Gun = %Gun
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:

	lock_camera()
	rotaing_camera(5)


func rotaing_camera(deg:int) -> void:
	if Input.is_action_just_released("left") and !(gun.scoped):
		rotation_degrees.y+=deg
	elif Input.is_action_just_released("right") and !(gun.scoped):
		rotation_degrees.y-=deg

	pass
func lock_camera() -> void:
	if position.y>11:
		position.y = 11
	elif position.y<=0:
		position.y =0
	pass
	

var speed = 1
func _on_button_pressed() -> void:
	position.y += speed
	pass # Replace with function body.


func _on_button_2_pressed() -> void:
	position.y += -speed
	pass # Replace with function body.
