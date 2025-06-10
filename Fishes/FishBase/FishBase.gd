extends CharacterBody2D
#class_name FishBase 

@onready var Sprite2d: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var tank: Node2D = $".."

@export var texture :Texture2D = load("res://Fishes/FishBase/assetsFiesh/GoldenFish.png")
@export var speed := 60.0
@export var change_dir_time := randf_range(2.0, 5.0)  # cada cuántos segundos cambia de dirección

var direction := Vector2.ZERO
var time_accum := 0.0
var screen_size := Vector2.ZERO

func _ready():
	Sprite2d.texture = texture
	screen_size = get_viewport_rect().size
	choose_random_direction()

func _physics_process(delta):
	
	var tank_node = get_tree().get_root().get_node("Aquarium/Tank")  # o $"../Tank" si está cerca
	if tank_node.is_calling_fish:
		move_towards(tank_node.target_position, 0.1)
	time_accum += delta

	# cambiar dirección cada cierto tiempo
	if time_accum > change_dir_time:
		choose_random_direction()
		time_accum = 0.0

	var new_position = position + direction * speed * delta
	animation_player.play("idel")
	# Evitar que se vaya de la pantalla
	if new_position.x < 0 or new_position.x > screen_size.x:
		direction.x *= -1
		Sprite2d.flip_h = direction.x < 0
	if new_position.y < 140 or new_position.y > screen_size.y:
		direction.y *= -1
	position += direction * speed * delta

func choose_random_direction():
	# Dirección aleatoria pero con algo de coherencia
	var angle = randf_range(0, 2 * PI)
	direction = Vector2(cos(angle), sin(angle)).normalized()
	
	Sprite2d.flip_h = direction.x < 0

func move_towards(point: Vector2, strength: float = 0.5):
	var dir_to_point = (point - position).normalized()
	direction = direction.lerp(dir_to_point, strength).normalized()
	Sprite2d.flip_h = direction.x < 0

func _on_tap(viewport: Node, event: InputEvent, shape_idx: int) -> void:##ARREGLAR
	if event is InputEventMouseButton and event.pressed:
		print("¡Tocaste al pez!")
		get_tree().get_root().get_node("Aquarium/Tank").tap_consumido = true  # <- Esto evita que llegue al tanque
