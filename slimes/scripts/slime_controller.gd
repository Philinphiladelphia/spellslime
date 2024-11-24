extends Node2D

var max_health = 200.0

var health = max_health

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$health_bar.bone_number = 11
	$damage_bar.bone_number = 11
	
	$health_bar.hide()
	$damage_bar.hide()

	var local_move_direction = Vector2(-1, -1)
	#get_child(0).apply_impulse(local_move_direction * 1000)

func set_max_health(amount):
	max_health = amount
	$health_bar.max_value = health
	$damage_bar.max_value = health
	
func set_health(amount):
	if amount <= max_health:
		health = amount
		$health_bar.current_health = health
		$damage_bar.current_health = health

func apply_damage(amount):
	health -= amount
	$health_bar.current_health = health
	$health_bar.show()
	
	$damage_bar.current_health = health
	$damage_bar.show()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (health <= 0):
		var timer = Timer.new()
		timer.wait_time = 4
		timer.one_shot = true
		add_child(timer)
		timer.connect("timeout", _on_timeout)
		timer.start()
		
		set_modulate(lerp(get_modulate(), Color(1,1,1,0), 0.1))
		
		# take away the slime's physics layer so it squishes easy
		$slime_soft_body.collision_layer = 0

func _on_timeout() -> void:
	process_mode = PROCESS_MODE_DISABLED
	queue_free()
