@tool

extends RigidBody3D

var in_body: Array
var target_location: Marker3D

var old_velocity: Vector3
var force: Vector3


enum STATES {
	UNHELD,
	HELD
}

var state: STATES = STATES.UNHELD


@export var collider: CollisionShape3D
@export var mesh_instance: MeshInstance3D
@export var push_off_area: CollisionShape3D

@onready var collider_shape := collider.shape as BoxShape3D
@onready var mesh_instance_shape := mesh_instance.mesh as BoxMesh
@onready var push_off_area_shape := push_off_area.shape as BoxShape3D

@export var sizing: Vector3 = Vector3(1, 1, 1)
@export var auto_weight = true



func _ready() -> void:
	scale = sizing
	
	#collider_shape.size = sizing
	#mesh_instance_shape.size = sizing
	#push_off_area_shape.size = sizing * 0.9
	if auto_weight: mass = sizing.x * sizing.y * sizing.z
	change_state(STATES.UNHELD, null)


func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		scale = sizing
		
		#collider_shape.size = sizing
		#mesh_instance_shape.size = sizing
		#push_off_area_shape.size = sizing * 0.9
	else:
		eject(delta)
		match state: 
			STATES.HELD:
				held(delta)


func held(_delta):
	pass


func change_state(new_state, new_target):
	state = new_state
	target_location = new_target
	match state:
		STATES.HELD:
			old_velocity = linear_velocity
			set_linear_damp(12)
			set_gravity_scale(0)
		STATES.UNHELD:
			old_velocity = Vector3.ZERO
			set_linear_damp(0)
			set_gravity_scale(2)


func eject(delta):
	if in_body:
		for item in in_body:
			item.linear_velocity += (item.global_position - global_position) * 200 * delta


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body != self:
		in_body.append(body)


func _on_area_3d_body_exited(body: Node3D) -> void:
	in_body.remove_at(in_body.find(body))
