extends Area3D

@onready var button_player: AnimationPlayer = $AnimationPlayer
@onready var text_player: AnimationPlayer = $text_player

var level_route: String = ""



func _on_body_entered(_body: Node3D) -> void:
	text_player.play("dialogue")
	button_player.play("pressed")


func _on_body_exited(_body: Node3D) -> void:
	button_player.play_backwards("pressed")
