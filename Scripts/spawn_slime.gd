extends Node2D

var slime = preload("res://Scenes/slimes/slime.tscn")
var clear_slime = preload("res://Scenes/slimes/slime_subtypes/clear_slime.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var instance = slime.instantiate()
	add_child(instance)

func inst(pos):
	var instance = slime.instantiate()
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
