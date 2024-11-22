extends PowderToyGodot

# this controls simulation speed
var sim_speed = 1
var accumulated_fractional_frame = 0.0

# Define configurable resolution
var x_resolution = 50
var y_resolution = 50

# Define configurable display scale
var display_scale = 1

var draw_rect_size_boost = 1.5

# Buffer for powder manifestation requests
var powder_manifestation_buffer = []

# Dictionary to store colors for each particle type
var particle_colors = {}

# Path to the JSON file
var colors_file_path = "res://addons/powder_toy_godot/colors.json"

# at the end of the day, this is just sampling resolution.
# we will only sample the array we have up to the specified extent.

func _ready() -> void:
	# powder toy settings
	set_edge_mode(2)
	set_pretty_powder(0)
	
	# Load colors from the JSON file
	load_colors()

func _process(delta: float) -> void:
	var frames_to_run = int(sim_speed)
	var fractional_frame = sim_speed - frames_to_run

	for i in range(frames_to_run):
		run_powder_toy_frame()

	accumulated_fractional_frame += fractional_frame
	if accumulated_fractional_frame >= 1.0:
		run_powder_toy_frame()
		accumulated_fractional_frame -= 1.0

	if sim_speed < 1.0:
		accumulated_fractional_frame += sim_speed
		if accumulated_fractional_frame >= 1.0:
			run_powder_toy_frame()
			accumulated_fractional_frame -= 1.0

	# Process buffered powder manifestation requests
	for request in powder_manifestation_buffer:
		manifest_powder_circle_wrapper(request.x, request.y, request.type, request.size)
	powder_manifestation_buffer.clear()

	get_particles_from_powder_toy()
	get_color_from_powder_toy()
	queue_redraw()

func _draw() -> void:
	var type_array = get_particle_type_array()
	for y in range(type_array.size()):
		for x in range(type_array[y].size()):
			var color_index = type_array[y][x]
			var color = get_color_from_index(color_index)
			draw_rect(Rect2(
				x * display_scale,
				y * display_scale,
				display_scale+draw_rect_size_boost, display_scale+draw_rect_size_boost), color)

func get_color_from_index(index: int) -> Color:
	if index == 0:
		return Color(0, 0, 0, 0) # Transparent
	if not particle_colors.has(index):
		# Assign a random color if not found
		particle_colors[index] = Color(randf(), randf(), randf())
		save_colors()
	return particle_colors[index]

func manifest_powder_circle_wrapper(x: int, y: int, type: int, size: int) -> void:
	# Translate coordinates from [0, x_resolution] to [0, x_resolution - 1]
	var translated_x = x
	var translated_y = y
	manifest_powder_circle(translated_x, translated_y, type, size)

func powder_circle(x, y, type, size):
	powder_manifestation_buffer.append({"x": x, "y": y, "type": type, "size": size}) # Example: different type and size

func load_colors() -> void:
	var file = FileAccess.open(colors_file_path, FileAccess.READ)
	if file:
		var json = JSON.new()
		var file_text = file.get_as_text()
		json.parse(file_text)
		var data = json.data
		for key in data.keys():
			particle_colors[int(key)] = str_to_var(data[key])
		file.close()

func save_colors() -> void:
	var file = FileAccess.open(colors_file_path, FileAccess.WRITE)
	if file:
		var data = {}
		for key in particle_colors.keys():
			data[str(key)] = var_to_str(particle_colors[key])
		var json_string = JSON.stringify(data, "\t")
		file.store_string(json_string)
		file.close()
