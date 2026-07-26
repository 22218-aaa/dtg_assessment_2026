extends Node3D

@export var level_information: Dictionary[String, level_data] = {}


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if level_information:
		print("success")
		global.level_information = level_information
	else:
		print("delayed")
		call_deferred("set_values")


func set_values() -> void:
	if level_information:
		print("success")
		global.level_information = level_information
	else:
		print("failed")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
