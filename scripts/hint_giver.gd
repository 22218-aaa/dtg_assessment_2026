extends Area3D

var level = global.level_information[global.current_level]
@onready var button_player: AnimationPlayer = $AnimationPlayer
@onready var hint_player: AnimationPlayer = $"../../AnimationPlayer"
@onready var text_player: AnimationPlayer = $"../../text_player"

var level_route: String = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(level.completion_types)
	for item in level.completion_types:
		if level.completion_types[item] == false:
			level_route = item
			return




func _on_body_entered(_body: Node3D) -> void:
	text_player.play("dialogue")
	button_player.play("pressed")


func _on_body_exited(_body: Node3D) -> void:
	button_player.play_backwards("pressed")
