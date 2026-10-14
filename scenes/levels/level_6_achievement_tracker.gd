extends Node3D


var tracker = acheivement_tracker.new()


func _ready() -> void:
	if global.easy_mode: $Label.visible = true
	tracker.completion_type = "..."
	tracker.start()


func _process(_delta: float) -> void:
	$Label.text = str(tracker.completion_type)


func _on_win_zone_body_entered(_body: Node3D) -> void:
	tracker.completed()
