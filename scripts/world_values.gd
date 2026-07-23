extends Node3D


@export var level_entries: Array[level_data] = []

@export var level_information: Dictionary = {}

func _ready() -> void:
	for entry in level_entries:
		level_information[entry.id] = entry
