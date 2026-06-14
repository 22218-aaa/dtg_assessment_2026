extends Node3D

@onready var spawning_platform: RigidBody3D = $spawning_platform
@onready var spawn_location: Marker3D = $spawning_platform/spawn_location
const BOX = preload("uid://ccpwjdyct6syf")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_pressure_plate_body_entered(_body: Node3D) -> void:
	
	for item in range(1):
		var inst = BOX.instantiate()
		inst.global_position = spawn_location.global_position
		get_parent().add_child(inst)
		spawning_platform.linear_velocity += Vector3.UP * 10
