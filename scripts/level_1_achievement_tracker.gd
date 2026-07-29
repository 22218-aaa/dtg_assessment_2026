extends Node3D


var level = global.current_level

var completion_type: String = "none"

var acceptable_completion_types = []


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for item in global.level_information[level].completion_types:
		acceptable_completion_types.append(item)
	print(acceptable_completion_types)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	$Label.text = completion_type


func _on_phasing_tracker_body_entered(_body: Node3D) -> void:
	completion_type = "wall collision"
