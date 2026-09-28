extends Node3D


@export var level_entries: Array[level_data] = []
var level_information: Dictionary[String, level_data] = {}
@export var player: RigidBody3D
@export var main_spawn_point: Marker3D

func _ready() -> void:
	if global.started == false: global.started = true
	else: player.position = main_spawn_point.position
		
	if level_entries:
		#print("success")
		for item in level_entries:
			level_information[item.level_name] = item
		global.level_information = level_information
	else:
		#print("delayed")
		call_deferred("set_values")


func set_values() -> void:
	if level_information:
		#print("success")
		for item in level_entries:
			level_information[item.level_name] = item
		global.level_information = level_information
	else:
		pass
		#print("failed")
