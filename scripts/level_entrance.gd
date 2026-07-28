@tool

extends Node3D

@export var level_name: String
var level_information: level_data

@onready var label: Label3D = $Label3D
@onready var scene_changer: Area3D = $scene_changer


func _ready() -> void:
	call_deferred("connect_level_data")


func connect_level_data():
	print()
	print("level entrance script: ")
	print(global.level_information)
	print(level_name)
	level_information = global.level_information[level_name]
	var label_text = ""
	label_text = level_name
	for item in level_information.completion_types:
		if level_information.completion_types[item] == true:
			label_text += "\n" + item + ": [✓]"
		else:
			label_text += "\n" + item + ": [ ]"
	
	label.text = label_text
	scene_changer.mesh_instance.mesh.material.set_albedo(level_information.completion_state_colours[level_information.completion_state])



func _process(_delta: float) -> void:
	if Engine.is_editor_hint():
		label.text = level_name


func _on_scene_changer_body_entered(body: Node3D) -> void:
	global.current_level = level_information.level_name
