extends Node3D

class_name acheivement_tracker

var level: level_data

var completion_type: String
var acceptable_completion_types = []


func start():
	level = global.level_information[global.current_level]
	for item in level.completion_types:
		acceptable_completion_types.append(item)
		print(acceptable_completion_types)


func completed() -> void:
	print("achievement check")
	if not completion_type in acceptable_completion_types:
		print("invalid type")
		return
	
	print("valid type")
	
	level.completion_types[completion_type] = true
	
	# change level state to beaten
	if level.completion_state == level.COMPLETION_STATES.UNBEATEN:
		level.completion_state = level.COMPLETION_STATES.BEATEN
	
	#change level state to be completed
	for item in level.completion_types:
		if level.completion_types[item] == false:
			return
	
	level.completion_state = level.COMPLETION_STATES.COMPLETED
