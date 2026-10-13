@tool

extends Area3D

@onready var player = get_tree().get_first_node_in_group("player")

@onready var collision_shape: CollisionShape3D = $CollisionShape3D
@onready var mesh_instance: MeshInstance3D = $MeshInstance3D
@onready var timer: Timer = $Timer

@export var sizing: Vector3 = Vector3(1, 1, 1)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	collision_shape.scale = sizing
	mesh_instance.scale = sizing


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Engine.is_editor_hint():
		collision_shape.scale = sizing
		mesh_instance.scale = sizing


func _on_body_entered(_body: Node3D) -> void:
	timer.start(0.5)
	player.screen_colour.set_color(Color(1.0, 0.0, 0.0, 0.392))
	get_tree().set_pause(true)


func _on_timer_timeout() -> void:
	get_tree().set_pause(false)
	player.screen_colour.set_color(Color(1.0, 0.0, 0.0, 0.0))
	get_tree().reload_current_scene()
