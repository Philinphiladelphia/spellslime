extends RigidBody2D

var projectile_scene : PackedScene
var slime_scene : PackedScene
var rotation_offset : float = 4.75
var rotation_speed : float = 1.3 # Increase the rotation speed for fast turning
var deadzone : float = 0.05 # Define a small deadzone

var clear_shader = preload("res://shaders/scenes/clear.tscn")

func _ready() -> void:
	# Load the projectile and slime scenes
	projectile_scene = preload("res://spell_machine_weapon/scenes/spell_projectile.tscn")
	slime_scene = preload("res://v1_slimes/slimes/slime.tscn")

func _process(delta: float) -> void:
	# Get the global mouse position
	var mouse_position = get_global_mouse_position()
	
	# Calculate the angle to the mouse position
	var target_angle = (mouse_position - global_position).angle() + rotation_offset
	
	# Calculate the difference between the current rotation and the target angle
	var angle_difference = wrapf(target_angle - rotation, -PI, PI)
	
	# Check if the angle difference is within the deadzone
	if abs(angle_difference) > deadzone:
		# Apply constant angular velocity towards the target angle
		if angle_difference > 0:
			angular_velocity = rotation_speed
		else:
			angular_velocity = -rotation_speed
	else:
		# Stop rotating if within the deadzone
		angular_velocity = 0

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		var node_to_fire
		if event.button_index == MOUSE_BUTTON_LEFT:
			node_to_fire = projectile_scene.instantiate()
			apply_firing_velocity(node_to_fire, 3000)
			node_to_fire.rotation = rotation + PI
		elif event.button_index == MOUSE_BUTTON_RIGHT:
			node_to_fire = slime_scene.instantiate()
			apply_firing_velocity(node_to_fire, 800)
		
		# Set the node's position to the marker's position
		node_to_fire.position = $ProjectileSpawnPoint.global_position
		
		#var my_shader = clear_shader.instantiate()
		#my_shader.add_child(node_to_fire)
		
		# add shader instead if you want a shader
		
		# Add the node to the scene
		get_parent().add_child(node_to_fire)

func apply_firing_velocity(node, velocity):
	var local_move_direction = Vector2(0, 1).rotated(get_global_transform().get_rotation())
	node.get_child(0).apply_impulse(local_move_direction * velocity)
