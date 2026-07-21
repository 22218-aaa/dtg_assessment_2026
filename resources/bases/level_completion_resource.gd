extends Resource



enum COMPLETION_STATES{
	UNBEATEN,
	BEATEN,
	COMPLETED
}


var entrance: String
@export var completion_state: COMPLETION_STATES
@export var completion_types: Dictionary[String, bool]
