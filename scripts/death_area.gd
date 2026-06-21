@tool

extends Area3D



@onready var collision_shape: CollisionShape3D = $CollisionShape3D
@onready var mesh_instance: MeshInstance3D = $MeshInstance3D

@export var sizing: Vector3 = Vector3(1, 1, 1)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		collision_shape.scale = sizing
		mesh_instance.scale = sizing


func _on_body_entered(body: Node3D) -> void:
	get_tree().reload_current_scene()
