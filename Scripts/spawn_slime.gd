extends Node2D

var slimenode = preload("res://Scenes/slime.tscn")
var playable_slime = preload("res://Scenes/playable_slime.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var instance = playable_slime.instantiate()
	add_child(instance)

func inst(pos):
	var instance = playable_slime.instantiate()
	instance.position = pos
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
