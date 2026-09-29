extends Node3D


var tracker = acheivement_tracker.new()


func _ready() -> void:
	if global.easy_mode: $Label.visible = true
	tracker.completion_type = "skip"
	tracker.start()


func _process(_delta: float) -> void:
	$Label.text = str(tracker.completion_type)


func _on_win_zone_body_entered(_body: Node3D) -> void:
	tracker.completed()


func _on_knowledge_check_tracker_body_entered(_body):
	tracker.completion_type = "knowledge_check"

func _on_skill_check_tracker_body_entered(_body):
	tracker.completion_type = "skill_check"

func _on_cheese_tracker_body_entered(_body):
	tracker.completion_type = "skip"
