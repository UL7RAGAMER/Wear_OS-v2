extends Node2D
var isinactive = false
@onready var timer: Timer = $Timer
var frame_counter = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	frame_counter += 1
	if frame_counter % 2 == 0:
		if is_hand_gestures_activate():
			restore()
		elif is_hand_gestures_deactivate():
			idle()


	pass



func is_hand_gestures_activate():
	var gyro =  Input.get_gyroscope()
	if round(rad_to_deg(gyro.x))>200 and Input.get_accelerometer().x<4 and isinactive :
		return true
	else :
		false
	
func is_hand_gestures_deactivate():
	var gyro =  Input.get_gyroscope()
	if round(rad_to_deg(gyro.x))<-200 and !isinactive:
		return true
	else :
		false
	
func restore():
	OS.set_low_processor_usage_mode(false)
	Engine.max_fps = 30
	isinactive = false
	timer.start()
	$ColorRect.visible = false
	Screen.restore()

func idle():
	isinactive = true
	timer.stop()
	$ColorRect.visible = true
	Screen.dim()
	OS.set_low_processor_usage_mode(true)

	Engine.max_fps = 10

func  _input(event: InputEvent) -> void:
	if event:
		if isinactive:
			restore()
		timer.start()
func _on_timer_timeout() -> void:
	idle()
	pass # Replace with function body.
