class_name level_data
extends Resource

var current_level: String


enum COMPLETION_STATES{
	UNBEATEN,
	BEATEN,
	COMPLETED
}

@export var level_name: String = ""
@export var completion_state: COMPLETION_STATES
@export var completion_types: Dictionary[String, bool] = {}
