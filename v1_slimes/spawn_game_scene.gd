extends Node

var scenenode = preload("res://spell_machine_weapon/scenes/spell_machine_weapon.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var instance = scenenode.instantiate()
	add_child(instance)
	
