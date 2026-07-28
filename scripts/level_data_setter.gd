extends Node3D


@export var level_entries: Array[level_data] = []
var level_information: Dictionary[String, level_data] = {}


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if level_entries:
		print("success")
		for item in level_entries:
			level_information[item.level_name] = item
		global.level_information = level_information
	else:
		print("delayed")
		call_deferred("set_values")


func set_values() -> void:
	if level_information:
		print("success")
		for item in level_entries:
			level_information[item.level_name] = item
		global.level_information = level_information
	else:
		print("failed")
