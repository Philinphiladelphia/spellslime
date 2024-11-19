extends RigidBody2D

var projectile_scene : PackedScene
var rotation_offset : float = 4.75
var rotation_speed : float = 1.3 # Increase the rotation speed for fast turning
var deadzone : float = 0.05 # Define a small deadzone

func _ready() -> void:
	# Load the projectile scene
	projectile_scene = preload("res://spell_machine_weapon/scenes/spell_projectile.tscn")

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
		if event.button_index == MOUSE_BUTTON_LEFT:
			fire_projectile(event.position)

func fire_projectile(target_position: Vector2) -> void:
	# Create an instance of the projectile
	var projectile = projectile_scene.instantiate()
	
	# Set the projectile's position to the marker's position
	projectile.transform = $ProjectileSpawnPoint.global_transform
	projectile.rotation = rotation + PI
	
	# Add the projectile to the scene
	get_parent().add_child(projectile)
