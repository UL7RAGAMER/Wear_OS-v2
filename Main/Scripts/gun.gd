class_name Gun
extends Node3D
var bullet = preload("res://Main/Scenes/bullet.tscn")
var ammo = 3
var shooting = false
@export var scoped = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	$"../../../Sniper ui/SniperLookFinderMesaDeTrabajo1".visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _input(event: InputEvent) -> void:
	sniper_ui()
	
func shoot(event:InputEventScreenTouch):
		ammo-=1
		$"../../../Sniper ui/Ammo".value = ammo
		var b = bullet.instantiate() as Area3D
		$"../../../SubViewport/Bullets".add_child(b)
		$"Operator valorent4/AnimationPlayer".seek(0)
		$"Operator valorent4/AnimationPlayer".play("Animation",-1,1.5)
		await get_tree().create_timer(1.5214/1.5).timeout
		$"Operator valorent4/AnimationPlayer".stop()
		shooting = false


		pass
		
func sniper_ui():
	if Input.is_action_just_pressed("snipe"):
		if !scoped:
			$"../../AnimationPlayer".play("Gun")
		else:
			$"../../AnimationPlayer".play_backwards("Gun")
			


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventScreenTouch and scoped:
		if event.is_pressed() and scoped and ammo and !shooting:
			shooting = true
			shoot(event)
		elif ammo == 0 and !shooting:
			$"../../AnimationPlayer".play_backwards("Gun")
			await get_tree().create_timer(1).timeout
			$"../../../Sniper ui/TouchScreenButton".visible = false
			$"Operator valorent4/AnimationPlayer".seek(1.5214)
			$"Operator valorent4/AnimationPlayer".play("Animation",-1,1.5)
			await get_tree().create_timer(5.1452/1.5).timeout
			$"Operator valorent4/AnimationPlayer".stop()
			$"../../../Sniper ui/TouchScreenButton".visible = true
			ammo = 3
			$"../../../Sniper ui/Ammo".value = ammo


			pass
			
	pass # Replace with function body.
