extends Node3D


var tracker = acheivement_tracker.new()
var box_togetherness: int = 0

func _ready() -> void:
	if global.easy_mode: $Label.visible = true
	tracker.completion_type = "flight‽"
	tracker.start()


func _process(_delta: float) -> void:
	$Label.text = str(tracker.completion_type)


func _on_win_zone_body_entered(_body: Node3D) -> void:
	tracker.completed()


func _on_phasing_tracker_body_entered(_body: Node3D) -> void:
	tracker.completion_type = "wall collision weirdness"


func _on_box_2_tracker_body_entered(_body: Node3D) -> void:
	box_togetherness += 1
	if box_togetherness == 3:
		tracker.completion_type = "the normal route"


func _on_box_2_tracker_body_exited(_body: Node3D) -> void:
	box_togetherness -= 1
	if box_togetherness  == 2:
		tracker.completion_type = "flight‽"
