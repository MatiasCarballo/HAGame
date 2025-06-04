extends Node

signal add_fish_requested
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_add_fish() -> void:
	
	emit_signal("add_fish_requested")
	print("llego un nuevo vecino...")
	


func _on_add_food_fish() -> void:
	print("llego la comidaaa")
	pass # Replace with function body.
