extends Control


@export var scroll_speed_bar: HScrollBar
@export var scroll_speed_display = Label
@export var sensitivity_bar: HScrollBar
@export var sensitivity_display = Label
@export var mode_indicator: HScrollBar


func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	mode_indicator.value = global.easy_mode
	scroll_speed_bar.value = global.scroll_speed
	scroll_speed_display.text = "scroll speed: " + str(global.scroll_speed)
	sensitivity_bar.value = global.sensitivity
	sensitivity_display.text = "sensitivity: " + str(global.sensitivity)


func _on_scroll_bar_value_changed(value):
	global.scroll_speed = scroll_speed_bar.value
	scroll_speed_display.text = "scroll speed: " + str(global.scroll_speed)


func _on_sensitivity_bar_value_changed(value):
	global.sensitivity = sensitivity_bar.value
	sensitivity_display.text = "sensitivity: " + str(global.sensitivity)




func _on_mode_indicator_value_changed(value):
	print(value)
	if value == 0.0:
		global.easy_mode = false
	else:
		global.easy_mode = true




func _on_button_pressed():
	if global.started == true:
		get_tree().change_scene_to_file("res://scenes/menus/hub_world.tscn")
	else:
		get_tree().change_scene_to_file("res://scenes/menus/starting_cut_scene.tscn")
