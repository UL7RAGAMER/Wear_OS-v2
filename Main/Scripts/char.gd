extends CharacterBody3D
class_name Enemy
@export var alebedo : Color
@onready var navigation_agent_3d: NavigationAgent3D = $NavigationAgent3D
@export var path3d: Array[Marker3D]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.play("mixamo_com")
	next_point()
	pass # Replace with function body.

@onready var timer: Timer = $Timer

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var destination = navigation_agent_3d.get_next_path_position()
	if !navigation_agent_3d.get_final_position() == navigation_agent_3d.get_next_path_position():
		look_at(destination,Vector3.UP,true)
	if navigation_agent_3d.get_final_position() == navigation_agent_3d.get_next_path_position():
		next_point()
	var base_low_poly_man: MeshInstance3D = $Skeleton3D/Mesh
	base_low_poly_man.mesh.surface_get_material(0).set_albedo(alebedo)
	var local_destination = destination - global_position
	var direction = local_destination.normalized()
	
	velocity = direction * 2.1
	move_and_slide()
	pass

func next_point():
	var n = randi_range(0,3)
	var ps = path3d[n].global_position
	navigation_agent_3d.set_target_position(ps)
	n+=1
func _on_area_3d_area_shape_entered(area_rid: RID, area: Area3D, area_shape_index: int, local_shape_index: int) -> void:
	print('asdkajhsdklaj')
	pass # Replace with function body.


func _on_timer_timeout() -> void:
	next_point()
	timer.start(randf_range(0,10))
	pass # Replace with function body.
