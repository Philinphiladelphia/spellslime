extends RigidBody2D

signal insert_powder_circle(x: int, y: int, type: int, size: int)

var damage = 5
var post_hit_lifespan = 0.5
var max_projectile_lifespan = 8
var died_of_old_age = false
var fade_duration = 0.5
var fade_speed = 0.05
var start_fade = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var timer = Timer.new()
	timer.wait_time = max_projectile_lifespan
	timer.one_shot = true
	add_child(timer)
	timer.connect("timeout", _lifespan_end)
	timer.start()
	
func _lifespan_end():
	died_of_old_age = true

func apply_firing_velocity():
	var local_move_direction = Vector2(0, -1).rotated(get_global_transform().get_rotation())
	apply_impulse(local_move_direction * 2000)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if start_fade or died_of_old_age:
		set_modulate(lerp(get_modulate(), Color(1,1,1,0), delta+fade_speed))
		var timer = Timer.new()
		timer.wait_time = fade_duration
		timer.one_shot = true
		add_child(timer)
		timer.connect("timeout", _on_die)
		timer.start()

func _on_area_2d_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	
	body.get_parent().get_parent().apply_damage(damage)
	
	var timer = Timer.new()
	timer.wait_time = post_hit_lifespan
	timer.one_shot = true
	add_child(timer)
	timer.connect("timeout", _start_fade)
	timer.start()
	
# how to move the powder viewport	

#var viewport = get_node("../../../PowderViewport")
#viewport.position = global_position
#collision_mask = 2

func _start_fade() -> void:
	start_fade = true

func _on_die() -> void:
	process_mode = PROCESS_MODE_DISABLED
	queue_free()
