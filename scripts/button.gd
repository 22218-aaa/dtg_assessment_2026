extends Button


@export var change_scene = "res://scenes/menus/main_menu.tscn"


func _on_pressed() -> void:
	call_deferred("change_scene_now")


func change_scene_now():
	get_tree().change_scene_to_file(change_scene)
