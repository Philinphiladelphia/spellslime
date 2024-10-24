extends Node

var scenenode = preload("res://Scenes/terrain.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var instance = scenenode.instantiate()
	var subview = get_node("SubViewport2")
	add_child(instance)
	
