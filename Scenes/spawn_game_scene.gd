extends Node

var scenenode = preload("res://Scenes/main.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var instance = scenenode.instantiate()
	add_child(instance)
	
