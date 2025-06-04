extends Node2D

var fish_scenes := {
	"GoldenFish": preload("res://Fishes/GoldenFish/GoldenFish.tscn")
}

func _ready():
	spawn_fishes_from_user_data()

func spawn_fishes_from_user_data():
	for fish_data in UserData.user_data["fishes"]:
		var raza = fish_data["raza"]
		if fish_scenes.has(raza):
			var fish_instance = fish_scenes[raza].instantiate()
			fish_instance.position = Vector2(randi_range(100, 600), randi_range(100, 400))
			add_child(fish_instance)
		else:
			print("⚠️ No se encontró la escena para el pez:", raza)

func spawn_fishes(raza):
	if fish_scenes.has(raza):
		var fish_instance = fish_scenes[raza].instantiate()
		fish_instance.position = Vector2(randi_range(100, 600), randi_range(100, 400))
		add_child(fish_instance)
		UserData.add_fish("GoldenFish")
	else:
		print("⚠️ No se encontró la escena para el pez:", raza)
