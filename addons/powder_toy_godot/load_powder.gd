extends Node

var powder_toy = preload("res://addons/powder_toy_godot/powder_toy.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var powder_instance = powder_toy.instantiate()
	add_child(powder_instance)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
