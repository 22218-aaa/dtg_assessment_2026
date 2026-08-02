extends Node3D


var level = global.current_level

var completion_type: String = "flight‽"

var acceptable_completion_types = []
var box_togetherness: int = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for item in global.level_information[level].completion_types:
		acceptable_completion_types.append(item)
	print(acceptable_completion_types)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	#$Label.text = str(completion_type)


func _on_phasing_tracker_body_entered(_body: Node3D) -> void:
	completion_type = "wall collision weirdness"



func _on_box_2_tracker_body_entered(_body: Node3D) -> void:
	box_togetherness += 1
	if box_togetherness == 3:
		completion_type = "the normal route"


func _on_box_2_tracker_body_exited(_body: Node3D) -> void:
	box_togetherness -= 1
	if box_togetherness  == 2:
		completion_type = "flight‽"


func _on_win_zone_body_entered(_body: Node3D) -> void:
	print("achievement check")
	if not completion_type in acceptable_completion_types:
		print("invalid type")
		return
	
	print("valid type")
	global.level_information[level].completion_types[completion_type] = true
	
