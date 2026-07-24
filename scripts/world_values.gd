extends Node3D


@export var level_entries = [0,21]

var level_information: Dictionary = {}



func _ready() -> void:
	call_deferred("set_values")


func set_values() -> void:
	print("aaa")
	print(level_entries)
	#if level_entries
	#for entry in level_entries:
	#	level_information[entry.level_name] = entry
