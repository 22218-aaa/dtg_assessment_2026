extends Node2D

@export var x = [1, 2]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(x)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
