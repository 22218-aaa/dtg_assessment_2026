extends RigidBody3D


@export_group("objects")
@export var camera: Camera3D
@export var object_detector: RayCast3D
@export var held_object_point: Marker3D
@export var flat_rotation: Marker3D
@export var boxes_label: Label
@export var position_label: Label
@export var velocity_label: Label
@export var highest_velocity_label: Label

@onready var distance_display: ColorRect = $Control/VBoxContainer/hold_distance_display/ColorRect/Marker2D/distance_display
@onready var current_distance_display: ColorRect = $Control/VBoxContainer/hold_distance_display/ColorRect/Marker2D/current_distance


var held_objects: Array = []

var static_stood_on: Array = []
var rigidbody_stood_on: Array = []
var on_floor: bool = true


const ACCELLERATION = 50.0
const FRICTION = 10.0
const JUMP_VELOCITY = 7
var sensitivity = 0.3
var highest_velocity: Vector3 = Vector3(0, 0, 0)

@export_category("variables")
@export_range(1.0, 100.0) var MAXIMUM_HOLDING_DISTANCE = 10.0
@export_range(-5.0, 50.0) var MINIMUM_HOLDING_DISTANCE = 0.1
@export_range(1, 999) var MAXIMUM_HELD_OBJECTS = 2

var scroll_speed = 0.2

# add player eject

func _input(event):
	if event is InputEventMouseMotion:
		flat_rotation.rotation_degrees.y += -event.relative.x * sensitivity
		camera.rotation_degrees.x += -event.relative.y * sensitivity
		camera.rotation_degrees.x = clamp(camera.rotation_degrees.x, -90, 90)
	if InputEvent:
		if Input.is_action_just_pressed("escape"):
			get_tree().change_scene_to_file("res://scenes/menus/starting_menu.tscn")
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		elif Input.is_action_just_pressed("tab"):
			get_tree().change_scene_to_file("res://scenes/menus/hub_world.tscn")
		if Input.is_action_just_pressed("select"):
			if not object_detector.is_colliding():
				if not held_objects.is_empty():
					held_objects[0].change_state(held_objects[0].STATES.UNHELD, null)
					held_objects.remove_at(0)
				return
			
			var object = object_detector.get_collider()
			
			if object in held_objects:
				held_objects.remove_at(held_objects.find(object))
				object.change_state(object.STATES.UNHELD, null)
			else:
				held_objects.append(object)
				object.change_state(object.STATES.HELD, held_object_point)
				if len(held_objects) > MAXIMUM_HELD_OBJECTS:
					held_objects[0].change_state(object.STATES.UNHELD, null)
					held_objects.remove_at(0)
				
		if Input.is_action_just_pressed("scroll_down"):
			held_object_point.position.z = move_toward(held_object_point.position.z, -MINIMUM_HOLDING_DISTANCE, scroll_speed)
			set_current_distance_display()
		
		if Input.is_action_just_pressed("scroll_up"):
			held_object_point.position.z = move_toward(held_object_point.position.z,- MAXIMUM_HOLDING_DISTANCE, scroll_speed)
			set_current_distance_display()

func set_current_distance_display():
	current_distance_display.position.x =-held_object_point.position.z * 8


func _ready() -> void:
	held_object_point.position.z = -snappedf((MAXIMUM_HOLDING_DISTANCE + MINIMUM_HOLDING_DISTANCE) / 2, scroll_speed)
	set_current_distance_display()
	scroll_speed = global.scroll_speed
	sensitivity = global.sensitivity
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	distance_display.position.x = MINIMUM_HOLDING_DISTANCE * 8
	distance_display.size.x = MAXIMUM_HOLDING_DISTANCE * 8 + 16 - MINIMUM_HOLDING_DISTANCE * 8


func _physics_process(delta: float) -> void:
	if linear_velocity.y > highest_velocity.y:
		highest_velocity = Vector3(0, linear_velocity.y, 0)
	
	# Add the gravity.
	if not on_floor:
		linear_velocity += get_gravity() * delta
	
	moving(delta)
	holding_logic(delta)
	#pushing_logic(delta)
	boxes_label.text = "held: " + str(len(held_objects)) + "/" + str(MAXIMUM_HELD_OBJECTS)
	position_label.text = "position: " + str(global_position.round())
	velocity_label.text = "velocity: " + str(linear_velocity.round())
	#highest_velocity_label.text = "highest velocity: " + str(highest_velocity.round())
	# + "\n" + \
	#str(rotation_degrees) + "\n" + \
	#str(flat_rotation.rotation_degrees) + "\n" + \
	#str(camera.rotation_degrees) + "\n"
	#move_and_slide()




#func pushing_logic(delta):
	#if rigidbody_stood_on:
		#if len(rigidbody_stood_on) == 1:
			#linear_velocity = Vector3(\
				#rigidbody_stood_on[0].linear_velocity.x, \
				#linear_velocity.y, \
				#rigidbody_stood_on[0].linear_velocity.z
			#)
			#rigidbody_stood_on[0].linear_velocity
			#
			#
			#
			#
			#
			#
			#linear_velocity += rigidbody_stood_on[0].force * 4


func holding_logic(delta):
	if not held_objects:
		return
	
	for item in held_objects:
		item.linear_velocity += (held_object_point.global_position - item.global_position) * 40 * delta



func moving(delta):
	#find direction the player will move in
	var input_dir = Input.get_vector("left", "right", "up", "down")
	var direction = (flat_rotation.global_transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	#friction based movement
	linear_velocity.x += ((direction.x * ACCELLERATION) - (linear_velocity.x * FRICTION)) * delta
	linear_velocity.z += ((direction.z * ACCELLERATION) - (linear_velocity.z * FRICTION)) * delta
	
	# Handle jump.
	if Input.is_action_just_pressed("jump") and on_floor:
		linear_velocity.y = JUMP_VELOCITY
	
	
	if position.y < -100:
		get_tree().reload_current_scene()


func _on_floor_detection_body_entered(body: Node3D) -> void:
	if body is RigidBody3D:
		rigidbody_stood_on.append(body)
	else:
		static_stood_on.append(body)
	on_floor = true


func _on_floor_detection_body_exited(body: Node3D) -> void:
	if body is RigidBody3D:
		rigidbody_stood_on.remove_at(rigidbody_stood_on.find(body))
	else:
		static_stood_on.remove_at(static_stood_on.find(body))
	if not static_stood_on and not rigidbody_stood_on:
		on_floor = false
