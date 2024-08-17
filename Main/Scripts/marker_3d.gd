extends Marker3D
var cur_pos = Vector3.ZERO
var last_pos = Vector3.ZERO
@onready var gun: Gun = %Gun
@export var x : Marker3D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position = x.global_position
	lock_camera()
	rotaing_camera(5)

func _input(event: InputEvent) -> void:
	if event is InputEventScreenDrag and !(gun.scoped):
		var dir = 0
		if event.relative.y >0:
			dir = 1
		elif event.relative.y <0:
			dir = -1
		position.y+=8*dir*get_process_delta_time()
func rotaing_camera(deg:int) -> void:
	if Input.is_action_just_released("left") and !(gun.scoped):
		rotation_degrees.y+=deg
	elif Input.is_action_just_released("right") and !(gun.scoped):
		rotation_degrees.y+=-deg
	pass
func lock_camera() -> void:
	if position.y>11:
		position.y = 11
	elif position.y<0:
		position.y = 0	
	pass
