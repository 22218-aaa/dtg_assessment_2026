extends Node3D


@export var level_entries: Array[level_data] = []
var level_information: Dictionary[String, level_data] = {}
@export var player: RigidBody3D
@export var main_spawn_point: Marker3D
@export var final_level: Node3D

@onready var label: Label = $Label

func _ready() -> void:
	global.current_level = ""
	
	# tutorial spawn point stuff
	if global.started == false: global.started = true
	else: player.position = main_spawn_point.position
	
	if global.level_information:
		check_completion()
		return
	final_level.position.y -= 200
	
	if level_entries:
		#print("success")
		for item in level_entries:
			level_information[item.level_name] = item
		global.level_information = level_information
		
	else:
		#print("delayed")
		call_deferred("set_values")
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	
	


func _process(_delta: float) -> void:
	label.text = str(Engine.get_frames_per_second())




func set_values() -> void:
	if level_information:
		#print("success")
		for item in level_entries:
			level_information[item.level_name] = item
		global.level_information = level_information
	else:
		pass
		#print("failed")


func check_completion():
	var x = false
	for level in global.level_information:
		for item in global.level_information[level].completion_types:
			if global.level_information[level].completion_types[item] == false:
				if not x:
					x = true
					return
				final_level.position.y -= 200
				return
