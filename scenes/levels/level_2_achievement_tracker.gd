extends Node3D


var tracker = acheivement_tracker.new()
var box_num = 0

func _ready() -> void:
	tracker.completion_type = "through and catch"
	tracker.start()


func _process(_delta: float) -> void:
	$Label.text = str(tracker.completion_type)


func _on_win_zone_body_entered(_body: Node3D) -> void:
	tracker.completed()



func _on_achievement_tracking_helper_body_entered(_body: Node3D) -> void:
	box_num += 1
	if box_num == 1:
		tracker.completion_type = "poke hole"
	if box_num == 2:
		tracker.completion_type = "boxes together forever"


func _on_achievement_tracking_helper_body_exited(_body: Node3D) -> void:
	box_num -= 1
	if box_num == 2:
		tracker.completion_type = "through and catch" 
