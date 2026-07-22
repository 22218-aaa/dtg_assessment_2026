@tool

extends Node3D

@export var level_name: String
var level_information: level_data

@onready var label: Label3D = $Label3D
@onready var scene_changer: Area3D = $scene_changer


func _ready() -> void:
	level_information = global.level_information[level_name]
	var label_text = ""
	label_text = level_name + "\n"
	for item in level_information


func _process(_delta: float) -> void:
	if Engine.is_editor_hint():
		scene_changer.mesh_instance.set_albedo()
