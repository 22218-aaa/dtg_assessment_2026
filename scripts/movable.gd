extends RigidBody3D


@export var director: Marker3D
var target_location: Marker3D

enum STATES {
	UNHELD,
	HELD
}

var state: STATES = STATES.UNHELD

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	match state: 
		STATES.HELD:
			held(delta)


func held(_jdelta):
	pass
	#global_rotation_degrees.y += \
	#(target_location.global_rotation_degrees.y - global_rotation_degrees.y) * 2 * delta
	#linear_velocity += (target_location.global_position - global_position) * 10 * delta
	#var turn_amount = target_location.global_rotation - global_rotation
	#angular_velocity = turn_amount / 100 * delta



func change_state(new_state, new_target):
	state = new_state
	target_location = new_target
	match state:
		STATES.HELD:
			set_gravity_scale(0)
		STATES.UNHELD:
			set_gravity_scale(5)
