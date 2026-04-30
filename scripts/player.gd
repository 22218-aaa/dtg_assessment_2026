extends RigidBody3D


@export var camera: Camera3D
@export var object_detector: RayCast3D
@export var floor_detector: RayCast3D
@export var held_object_point: Marker3D
@export var flat_rotation: Marker3D
@export var label: Label

var held_objects: Array = []


const MAXIMUM_HOLDING_DISTANCE = -10.0
const MINIMUM_HOLDING_DISTANCE = -0.1
const SCROLL_SPEED = 0.1

const ACCELLERATION = 50.0
const FRICTION = 10.0
const JUMP_VELOCITY = 7
const sensitivity = 0.3

func _input(event):
	if event is InputEventMouseMotion:
		flat_rotation.rotation_degrees.y += -event.relative.x * sensitivity
		camera.rotation_degrees.x += -event.relative.y * sensitivity
		camera.rotation_degrees.x = clamp(camera.rotation_degrees.x, -90, 90)
	if InputEvent:
		if Input.is_action_just_pressed("escape"):
			get_tree().quit()
		if Input.is_action_just_pressed("select"):
			if object_detector.is_colliding():
				if object_detector.get_collider() in held_objects:
					object_detector.get_collider().set_gravity_scale(1)
					held_objects.remove_at(held_objects.find(object_detector.get_collider()))
				else:
					object_detector.get_collider().set_gravity_scale(0)
					held_objects.append(object_detector.get_collider())
		if Input.is_action_just_pressed("scroll_down"):
			held_object_point.position.z = move_toward(held_object_point.position.z, MINIMUM_HOLDING_DISTANCE, SCROLL_SPEED)
		
		if Input.is_action_just_pressed("scroll_up"):
			held_object_point.position.z = move_toward(held_object_point.position.z, MAXIMUM_HOLDING_DISTANCE, SCROLL_SPEED)



func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not floor_detector.is_colliding():
		linear_velocity += get_gravity() * delta
	
	# Handle jump.
	if Input.is_action_just_pressed("jump") and floor_detector.is_colliding():
		linear_velocity.y = JUMP_VELOCITY
	
	moving(delta)
	holding_logic(delta)
	
	label.text = str(held_objects)
	# + "\n" + \
	#str(rotation_degrees) + "\n" + \
	#str(flat_rotation.rotation_degrees) + "\n" + \
	#str(camera.rotation_degrees) + "\n"
	#move_and_slide()


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
	
	if position.y < -100:
		get_tree().reload_current_scene()
