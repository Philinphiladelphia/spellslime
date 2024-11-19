extends Node2D

var slime = preload("res://v1_slimes/slimes/slime.tscn")
var clear_slime = preload("res://v1_slimes/slimes/slime_subtypes/clear_slime.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var instance = slime.instantiate()
	instance.position = Vector2(600, -100)
	add_child(instance)

func inst(pos):
	pass
	
func _input(event):
	if event is InputEventMouseButton && event.pressed:
		inst(get_global_mouse_position())
