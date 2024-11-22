extends Node2D

var slime = preload("res://slimes/slimes/slime.tscn")
var med_slime = preload("res://slimes/scenes/med_slime.tscn")
var large_slime = preload("res://slimes/scenes/large_slime.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func inst(pos, slime_scene):
	var instance = slime_scene.instantiate()
	instance.position = pos
	add_child(instance)
	
	
		#if event is InputEventMouseButton and event.pressed:
		#var node_to_fire
		#if event.button_index == MOUSE_BUTTON_LEFT:
func _input(event):
	if event is InputEventMouseButton and event.pressed:
		var pos = get_global_mouse_position()
		if event.button_index == MOUSE_BUTTON_LEFT:
			inst(pos, slime)
		elif event.button_index == MOUSE_BUTTON_RIGHT:
			inst(pos, med_slime)
		elif event.button_index == MOUSE_BUTTON_MIDDLE:
			inst(pos, large_slime)
