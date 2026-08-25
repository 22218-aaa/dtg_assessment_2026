extends Node3D


var level = global.level_information[global.current_level]


var completion_type: String = "under"

var acceptable_completion_types = []
var box_togetherness: int = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for item in level.completion_types:
		acceptable_completion_types.append(item)
	print(acceptable_completion_types)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	$Label.text = str(completion_type)





func _on_win_zone_body_entered(_body: Node3D) -> void:
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
	


func _on_over_tracker_body_entered(_body: Node3D) -> void:
	completion_type = "over"


func _on_through_tracker_body_entered(_body: Node3D) -> void:
	completion_type = "through and under"
