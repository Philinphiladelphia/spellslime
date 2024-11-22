extends Node2D

@onready var powder_toy = $PowderToyGodot
var current_x = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	powder_toy.sim_speed = 1.0
	powder_toy.set_edge_mode(0)
	#powder_toy.powder_circle(80, 140, 20, 17)
	
	powder_toy.powder_circle(100, 60, 20, 114)
	powder_toy.powder_circle(100, 100, 20, 114)
	powder_toy.powder_circle(100, 140, 20, 114)
	
	powder_toy.powder_circle(100, 190, 3, 4)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:	
	pass

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		var mouse_pos = event.position
		var scaled_pos = scale_position(mouse_pos)
		#powder_toy.powder_circle(scaled_pos.x, scaled_pos.y, 12, 87)

func scale_position(pos: Vector2) -> Vector2:
	var viewport_size = get_viewport().size
	var center_two_thirds = viewport_size * (2.0 / 3.0)
	var offset = (viewport_size) / 2.0
	var scaled_x = (pos.x - offset.x) / center_two_thirds.x * 100
	var scaled_y = (pos.y - offset.y) / center_two_thirds.y * 100
	return Vector2(scaled_x, scaled_y)
