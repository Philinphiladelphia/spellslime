extends TextureProgressBar

var slime_soft_body

var current_health = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var parent = get_parent()
	slime_soft_body = parent.get_node("slime_soft_body/Bone-8")
	max_value = parent.max_health
	current_health = parent.max_health
	value = parent.max_health

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	value = current_health
	position = slime_soft_body.position - Vector2(350, 600)
