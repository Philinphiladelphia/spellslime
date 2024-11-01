extends Node2D

var small_slime = preload("res://Scenes/slimes/small_slime.tscn")

var clear_shader = preload("res://Shaders/clear.tscn")
var rainbow_shader = preload("res://Shaders/rainbow.tscn")
var color_glow_shader = preload("res://Shaders/color_glow.tscn")

var shaders = [clear_shader, rainbow_shader]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func gen_color():
	return Color.from_hsv(randf_range(0.0, 1.0), 1.0, 1.0)

func random_colored_slime():
	var glow = color_glow_shader.instantiate()
	glow.material.set_shader_parameter("glow_color", gen_color())
	return apply_shader(small_slime.instantiate(), glow)
	
func random_shader_slime():
	randomize()
	var random_index = randi() % shaders.size()
	var chosen_shader = shaders[random_index]
	
	return apply_shader(small_slime.instantiate(), chosen_shader.instantiate())

func inst(pos):
	var slime = random_colored_slime()
	slime.position = pos
	add_child(slime)
	
func apply_shader(slime, shader):
	shader.add_child(slime)
	return shader
	
func _input(event):
	# Mouse in viewport coordinates.
	if event is InputEventMouseButton && event.pressed:
		print("Mouse Click/Unclick at: ", event.position)
		inst(get_global_mouse_position())
	elif event is InputEventMouseMotion:
		print("Mouse Motion at: ", event.position)

	# Print the size of the viewport.
	print("Viewport Resolution is: ", get_viewport().get_visible_rect().size)
