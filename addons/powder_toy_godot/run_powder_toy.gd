extends PowderToyGodot

# this controls simulation speed
var sim_frames_per_godot_frame = 1
var accumulated_fractional_frame = 0.0

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	var frames_to_run = int(sim_frames_per_godot_frame)
	var fractional_frame = sim_frames_per_godot_frame - frames_to_run

	for i in range(frames_to_run):
		run_powder_toy_frame()

	accumulated_fractional_frame += fractional_frame
	if accumulated_fractional_frame >= 1.0:
		run_powder_toy_frame()
		accumulated_fractional_frame -= 1.0

	get_particles_from_powder_toy()
	queue_redraw()

func _draw() -> void:
	var stored_array = get_stored_array()
	for y in range(stored_array.size()):
		for x in range(stored_array[y].size()):
			var color_index = stored_array[y][x]
			var color = get_color_from_index(color_index)
			draw_rect(Rect2((x * 5) - 500, (y * 5) - 500, 5, 5), color)

func get_color_from_index(index: int) -> Color:
	if index == 0:
		return Color(0, 0, 0, 0) # Transparent
	var colors = [
		Color(1, 0, 0), # Red
		Color(0, 1, 0), # Green
		Color(0, 0, 1), # Blue
		Color(1, 1, 0), # Yellow
		Color(1, 0, 1), # Magenta
		Color(0, 1, 1)  # Cyan
	]
	return colors[index % colors.size()]

func manifest_powder_circle_wrapper(x: int, y: int, type: int, size: int) -> void:
	# Translate coordinates from [-100, 100] to [0, 199]
	var translated_x = x + 100
	var translated_y = y + 100
	manifest_powder_circle(translated_x, translated_y, type, size)

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		var mouse_pos = event.position
		# Convert mouse position to the coordinate system used by manifest_powder_circle_wrapper
		var x = int(mouse_pos.x / 5) - 100
		var y = int(mouse_pos.y / 5) - 100
		
		if event.button_index == MOUSE_BUTTON_LEFT:
			# Left click
			manifest_powder_circle_wrapper(x, y, 10, 17)
		elif event.button_index == MOUSE_BUTTON_RIGHT:
			# Right click - do something different
			manifest_powder_circle_wrapper(x, y, 10, 87) # Example: different type and size
