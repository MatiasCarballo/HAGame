extends Node

var tap_consumido := false
var target_position: Vector2 = Vector2.ZERO
var call_duration := 0.5  # segundos que dura el "llamado"
var call_timer := 0.0
var is_calling_fish := false

signal screen_touched(pos: Vector2)
@onready var fishes: Node2D = $Fishes

# Called when the node enters the scene tree for the first time.
func _process(delta):
	if is_calling_fish:
		call_timer -= delta
		if call_timer <= 0:
			is_calling_fish = false

func _on_add_fish_requested():
	fishes.spawn_fishes("GoldenFish")

func _on_tank_area_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:

	if event is InputEventMouseButton and event.pressed:
		if tap_consumido:
			tap_consumido = false  # Resetear para la próxima vez
		else:
			target_position = event.position
			call_timer = call_duration
			is_calling_fish = true
			print("¡Tocaste el tanque!")
