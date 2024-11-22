extends TextureProgressBar

var current_health = 0.0
var slime_soft_body
var lerp_addition = 0.08

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var parent = get_parent()
	slime_soft_body = parent.get_node("slime_soft_body/Bone-8")
	max_value = parent.max_health
	current_health = parent.max_health
	value = parent.max_health

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position = slime_soft_body.position - Vector2(350, 600)
	var new_value = lerp(value, current_health + (step*2), delta+lerp_addition)
	
	# give the asymptote an endpoint
	if abs(value-new_value) < (step*2):
		value = current_health
	else:
		value = new_value
