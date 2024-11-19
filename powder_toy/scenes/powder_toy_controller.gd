extends Node2D

@onready var powder_toy = $PowderToyGodot

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	powder_toy.manifest_powder_circle_wrapper(0, 0, 20, 17)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	powder_toy.manifest_powder_circle_wrapper(0, 70, 5, 49)
	powder_toy.manifest_powder_circle_wrapper(0, -70, 1, 2)
	pass
