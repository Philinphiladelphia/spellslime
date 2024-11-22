extends Node

var scenenode = preload("res://v1_slimes/environment/background/forest.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var instance = scenenode.instantiate()
	add_child(instance)
	
