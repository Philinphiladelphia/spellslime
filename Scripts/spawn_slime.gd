extends Node2D

var slimenode = preload("res://Scenes/slime.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	#inst(Vector2(0,0))
	
	#inst(Vector2(100,0))

func inst(pos):
	var instance = slimenode.instantiate()
	instance.position = pos
	var slime_node = instance.get_child(0)
	var slime_body = slime_node.get_child(0)
	#slime_body.scale = Vector2(2,2)
	var subview = get_node("SubViewport2")
	add_child(instance)
	
func _input(event):
	# Mouse in viewport coordinates.
	if event is InputEventMouseButton && event.pressed:
		print("Mouse Click/Unclick at: ", event.position)
		inst(get_global_mouse_position())
	elif event is InputEventMouseMotion:
		print("Mouse Motion at: ", event.position)

	# Print the size of the viewport.
	print("Viewport Resolution is: ", get_viewport().get_visible_rect().size)
