class_name level_data
extends Resource

var current_level: String


enum COMPLETION_STATES{
	UNBEATEN,
	BEATEN,
	COMPLETED
}

var completion_state_colours = {
	COMPLETION_STATES.UNBEATEN: Color(1.0, 0.0, 0.0, 1.0),
	COMPLETION_STATES.BEATEN: Color(1.0, 1.0, 0.0, 1.0),
	COMPLETION_STATES.COMPLETED: Color(0.0, 1.0, 0.0, 1.0),
	
}

#@export var level_name: String = ""
@export var completion_state: COMPLETION_STATES
@export var completion_types: Dictionary[String, bool] = {}
