@tool

extends Area3D



@onready var collision_shape: CollisionShape3D = $CollisionShape3D

@export var sizing: Vector3 = Vector3(1, 1, 1)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	collision_shape.scale = sizing


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Engine.is_editor_hint():
		collision_shape.scale = sizing
