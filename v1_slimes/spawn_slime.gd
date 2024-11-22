extends Node2D

var slime = preload("res://v1_slimes/slimes/slime.tscn")
var clear_slime = preload("res://v1_slimes/slimes/slime_subtypes/clear_slime.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func inst(pos):
	var instance = slime.instantiate()
	instance.position = pos
	add_child(instance)
	
func _input(event):
	if event is InputEventMouseButton && event.pressed:
		inst(get_global_mouse_position())
