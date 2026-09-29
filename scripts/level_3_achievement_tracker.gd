extends Node3D


var tracker = acheivement_tracker.new()


func _ready() -> void:
	if global.easy_mode: $Label.visible = true
	tracker.completion_type = "under"
	tracker.start()


func _process(_delta: float) -> void:
	$Label.text = str(tracker.completion_type)


func _on_win_zone_body_entered(_body: Node3D) -> void:
	tracker.completed()


func _on_over_tracker_body_entered(_body: Node3D) -> void:
	tracker.completion_type = "over"


func _on_through_tracker_body_entered(_body: Node3D) -> void:
	tracker.completion_type = "through and under"
