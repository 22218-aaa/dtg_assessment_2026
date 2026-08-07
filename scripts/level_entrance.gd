@tool

extends Node3D

@export var level_name: String
@export var level_path: String

var level_information: level_data

@onready var area_3d: Area3D = $Area3D
@onready var collision_shape: CollisionShape3D = $Area3D/CollisionShape3D
@onready var mesh_instance: MeshInstance3D = $Area3D/MeshInstance3D
@onready var label: Label3D = $Label3D

@export var sizing: Vector3 = Vector3(1, 1, 1)


func _ready() -> void:
	if not Engine.is_editor_hint():
		call_deferred("connect_level_data")
		collision_shape.scale = sizing
		mesh_instance.scale = sizing


func connect_level_data():
	#print()
	#print("level entrance script: ")
	#print(global.level_information)
	#print(level_name)
	level_information = global.level_information[level_name]
	var label_text = ""
	label_text = level_name
	for item in level_information.completion_types:
		if level_information.completion_types[item] == true:
			label_text += "\n" + item + ": [✓]"
		else:
			label_text += "\n" + item + ": [ ]"
	
	label.text = label_text
	mesh_instance.mesh.material.set_albedo(level_information.completion_state_colours[level_information.completion_state])



func _process(_delta: float) -> void:
	if Engine.is_editor_hint():
		label.text = level_name
		collision_shape.scale = sizing
		mesh_instance.scale = sizing



func _on_area_3d_body_entered(_body: Node3D) -> void:
	global.current_level = level_information.level_name
	get_tree().change_scene_to_file(level_path)
