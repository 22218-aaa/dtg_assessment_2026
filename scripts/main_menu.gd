extends Control


@onready var scroll_bar = $CenterContainer2/VBoxContainer/HScrollBar
@onready var label = $CenterContainer2/VBoxContainer/Label


func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	scroll_bar.value = global.scroll_speed
	label.text = "scroll speed: " + str(global.scroll_speed)


func _on_scroll_bar_value_changed(value):
	global.scroll_speed = scroll_bar.value
	label.text = "scroll speed: " + str(global.scroll_speed)


func _on_button_pressed():
	if global.started == true:
		get_tree().change_scene_to_file("res://scenes/menus/hub_world.tscn")
	else:
		get_tree().change_scene_to_file("res://scenes/menus/starting_cut_scene.tscn")
