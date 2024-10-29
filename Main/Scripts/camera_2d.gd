@tool
extends Camera2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	zoom=Vector2(1.32,1.32)
	editor_draw_screen = false
	pass # Replace with function body.

		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:

	pass
	
func _draw() -> void:
	draw_circle(Vector2.ZERO,170,Color.PALE_GOLDENROD,false,1,true)
