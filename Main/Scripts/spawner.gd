extends Node3D
var enemy = preload("res://Main/Scenes/char.tscn")
@onready var square1: Node3D = $"../Building/Floors/NavigationRegion3D/Floor1/Square"
@onready var square2: Node3D = $"../Building/Floors/NavigationRegion3D/Floor2/Square"
@onready var square3: Node3D = $"../Building/Floors/NavigationRegion3D/Floor3/Square"
var squares:Array
var max_enemy = 7
var curr_enemy = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	squares.append_array([square1,square2,square3])
	pass # Replace with function body.

func spawning():
	var enem = enemy.instantiate() as Enemy
	var s = squares.pick_random()
	var marker : Marker3D
	for i in range(4):
		marker = s.get_child(i)
		enem.path3d.append(marker)
	enem.global_position = marker.global_position
	enem.scale = Vector3(41.248,41.248,41.248)
	add_child(enem)
# Called every frame. 'delta' is the elapsed time since the previous frame.
@onready var timer: Timer = $Timer
var is_timer = false
func _process(delta: float) -> void:
	if curr_enemy< max_enemy and !is_timer:
		timer.start(randf_range(0,3))
		is_timer = true
	pass


func _on_timer_timeout() -> void:
	spawning()
	timer.stop()
	curr_enemy+=1
	is_timer= false
	pass # Replace with function body.
