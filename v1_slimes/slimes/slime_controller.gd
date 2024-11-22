extends Node2D

var max_health = 20

var health = max_health

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass

func apply_damage(amount):
	health -= amount
	$TextureProgressBar.show()
	$TextureProgressBar.value = health
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (health == max_health):
		$TextureProgressBar.hide()
	
	if (health <= 0):
		var timer = Timer.new()
		timer.wait_time = 4
		timer.one_shot = true
		add_child(timer)
		timer.connect("timeout", _on_timeout)
		timer.start()
		
		$TextureProgressBar.hide()
		
		set_modulate(lerp(get_modulate(), Color(1,1,1,0), 0.05))
		
		# allow the slime to break before it dies
		$slime_soft_body.break_distance_ratio = 1.1
		
		$slime_soft_body.collision_layer = 0

func _on_timeout() -> void:
	process_mode = PROCESS_MODE_DISABLED
	queue_free()
