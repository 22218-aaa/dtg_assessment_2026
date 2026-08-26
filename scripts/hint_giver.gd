extends Area3D

var level = global.level_information[global.current_level]
@onready var button_player: AnimationPlayer = $AnimationPlayer
@onready var hint_player: AnimationPlayer = $"../../AnimationPlayer"
@onready var text_player: AnimationPlayer = $"../../text_player"
@onready var mesh: MeshInstance3D = $"../../AnimationPlayer/MeshInstance3D"
@export var dialogue: bool

var level_route: String = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mesh.visible = false
	print(level.completion_types)
	for item in level.completion_types:
		if level.completion_types[item] == false:
			level_route = item
			return


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node3D) -> void:
	if dialogue:
		text_player.play("dialogue")
	else:
		button_player.play("pressed")
		mesh.visible = true
		hint_player.play(level_route)
		await hint_player.animation_finished
		mesh.visible = false


func _on_body_exited(body: Node3D) -> void:
	if not dialogue:
		button_player.play_backwards("pressed")
