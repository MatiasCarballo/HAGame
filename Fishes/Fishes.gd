extends Node2D

var pathFishBase = preload("res://Fishes/FishBase/FishBase.tscn")

var fish_scenes := {
	"GoldenFish":pathFishBase ,
	"BlueFish":pathFishBase,
	"GreenFish":pathFishBase,
	"PinkFish":pathFishBase,
	"VioletFish":pathFishBase
}

func _ready():
	spawn_fishes_from_user_data()

func spawn_fishes_from_user_data():
	var fishesData = TankData.getFish("6842259f37e5e42a225f64a9")
	for fish_data in fishesData:
		var raza = fish_data["raza"]
		print(raza)
		if fish_scenes.has(raza):
			var fish_instance = fish_scenes[raza].instantiate()
			fish_instance.texture = load("res://Fishes/FishBase/assetsFiesh/%s.png" % raza)
			fish_instance.position = Vector2(randi_range(100, 600), randi_range(100, 400))
			add_child(fish_instance)
		else:
			print("⚠️ No se encontró la escena para el pez:", raza)

func spawn_fishes(raza):
	if fish_scenes.has(raza):
		var res: bool =await  TankData.addFish("6842259f37e5e42a225f64a9", "GoldenFish", "male")
		if res:
			var fish_instance = fish_scenes[raza].instantiate()
			fish_instance.position = Vector2(randi_range(100, 600), randi_range(100, 400))
			add_child(fish_instance)
	else:
		print("⚠️ No se encontró la escena para el pez:", raza)
