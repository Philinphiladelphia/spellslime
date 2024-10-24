# addons/softbody2d/test_softbody2d.gd

extends GutTest

var SoftBody2D = load('res://addons/softbody2d/softbody2d.gd')

func test_initialization():
	var softbody = SoftBody2D.new()
	assert_true(softbody != null, "SoftBody2D instance should be created")

func test_property_setters():
	var softbody = SoftBody2D.new()
	
	softbody.vertex_interval = 20
	assert_eq(softbody.vertex_interval, 20, "vertex_interval should be set to 20")
	
	softbody.pattern_type = "rectangle"
	assert_eq(softbody.pattern_type, "rectangle", "pattern_type should be set to rectangle")
	
	softbody.min_alpha = 0.1
	assert_eq(softbody.min_alpha, 0.1, "min_alpha should be set to 0.1")
	
	softbody.margin_pixels = 5
	assert_eq(softbody.margin_pixels, 5, "margin_pixels should be set to 5")

func test_joint_removal():
	var softbody = SoftBody2D.new()
	var joint_removed_called = false
	
	softbody.connect("joint_removed", Callable(self, "_on_joint_removed"))
	
	# Simulate adding joints and removing one
	var rigid_body_a = SoftBody2D.SoftBodyChild.new()
	var rigid_body_b = SoftBody2D.SoftBodyChild.new()
	#var joint = Joint2D.new()
	#
	#softbody.remove_joint(rigid_body_a, joint)
	#
	#assert_true(joint_removed_called, "joint_removed signal should be emitted")

#func _on_joint_removed(rigid_body_a, rigid_body_b):
	#joint_removed_called = true

#func test_create_softbody2d():
	#var softbody = SoftBody2D.new()
	#softbody.texture = preload("res://path_to_some_texture.png")
	#softbody.create_softbody2d()
	#
	#assert_true(softbody.get_child_count() > 0, "Softbody should have children after creation")
