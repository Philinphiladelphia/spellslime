extends Node2D

var max_health = 200.0

var health = max_health
# I need to define something similar to a powder hitbox. If powder enters that region, it deals damage to the tower.
# I'll also need to maintain a seperate json damage map for each powder type. Some types may even be 0 damage or negative damage (heal the tower).
# powder of different types deal damage for each second within the defined powder hitbox zone. The damage is added up every frame.


# for now, if a slime touches the tower, the tower will take damage.

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	
func apply_damage(amount):
	health -= amount
	$health_bar.current_health = health
	$health_bar.show()
	
	$damage_bar.current_health = health
	$damage_bar.show()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (health == max_health):
		$health_bar.hide()
		$damage_bar.hide()
	
	if (health <= 0):
		var timer = Timer.new()
		timer.wait_time = 4
		timer.one_shot = true
		add_child(timer)
		timer.connect("timeout", _on_timeout)
		timer.start()
		
		$health_bar.hide()

func _on_timeout() -> void:
	process_mode = PROCESS_MODE_DISABLED
	queue_free()
