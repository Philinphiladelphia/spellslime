extends RigidBody2D

var projectile_scene : PackedScene
var slime_scene : PackedScene
var rotation_offset : float = 4.75
var rotation_speed : float = 1.3 # Increase the rotation speed for fast turning
var deadzone : float = 0.05 # Define a small deadzone

func _ready() -> void:
	# Load the projectile and slime scenes
	projectile_scene = preload("res://spell_machine_weapon/scenes/spell_projectile.tscn")
	slime_scene = preload("res://slimes/scenes/slime.tscn")

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
		angular_velocity = 0
		

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		var node_to_fire
		if event.button_index == MOUSE_BUTTON_LEFT:
			node_to_fire = projectile_scene.instantiate()
			apply_firing_velocity(node_to_fire, 1000)
			node_to_fire.rotation = rotation + PI
		elif event.button_index == MOUSE_BUTTON_RIGHT:
			node_to_fire = slime_scene.instantiate()
			apply_firing_velocity(node_to_fire, 800)
		else:
			return
		
		# Add the node to the scene
		$Node/ProjectileSpawnPoint.add_child(node_to_fire)
		var mouse_position = get_global_mouse_position()
		var target_angle = (mouse_position - global_position).angle() + rotation_offset
		var projectile_location_vector = Vector2.DOWN.rotated(target_angle)
		
		node_to_fire.position = get_parent().get_parent().global_position + projectile_location_vector * 300 + (Vector2.UP * 150)
		node_to_fire.rotation = target_angle

func apply_firing_velocity(node, velocity):
	var local_move_direction = Vector2(0, 1).rotated(get_global_transform().get_rotation())
	node.get_child(0).apply_impulse(local_move_direction * velocity)
