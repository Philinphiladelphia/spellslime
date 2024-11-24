extends Node2D

var slime = preload("res://slimes/scenes/slime.tscn")
var med_slime = preload("res://slimes/scenes/med_slime.tscn")
var large_slime = preload("res://slimes/scenes/large_slime.tscn")

var max_slimes = 10
var max_med_slimes = 5
var max_large_slimes = 2

var slime_cooldown = 0.5
var last_spawn_time = 0.0

var slime_count = 0
var med_slime_count = 0
var large_slime_count = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func inst(pos, slime_scene):
	var instance = slime_scene.instantiate()
	
	if slime_scene == slime:
		instance.set_max_health(100.0)
		instance.set_health(100.0)
		slime_count += 1
	elif slime_scene == med_slime:
		instance.set_max_health(500.0)
		instance.set_health(500.0)
		med_slime_count += 1
	elif slime_scene == large_slime:
		instance.set_max_health(1000.0)
		instance.set_health(1000.0)
		large_slime_count += 1
		

	instance.position = pos
	add_child(instance)

func _input(event):
	var current_time = Time.get_ticks_msec() / 1000.0
	if current_time - last_spawn_time < slime_cooldown:
		return

	var pos = get_global_mouse_position()
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_RIGHT and med_slime_count < max_med_slimes:
			inst(pos, med_slime)
			last_spawn_time = current_time
		elif event.button_index == MOUSE_BUTTON_MIDDLE and large_slime_count < max_large_slimes:
			inst(pos, large_slime)
			last_spawn_time = current_time
	elif Input.is_key_pressed(KEY_SPACE) and slime_count < max_slimes:
		inst(pos, slime)
		last_spawn_time = current_time
