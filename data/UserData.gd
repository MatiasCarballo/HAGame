extends Node

const SAVE_PATH := "res://data/user_data.json"
var user_data := {}

func _ready():
	load_data()

func load_data():
	if not FileAccess.file_exists(SAVE_PATH):
		print("📝 Archivo de datos no existe. Creando uno nuevo...")
		user_data = {
			"user": "00",
			"_id": "00",
			"money": "00000",
			"fishes": []
		}
		save_data()
	else:
		var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
		var text = file.get_as_text()
		file.close()

		var parsed = JSON.parse_string(text)
		if typeof(parsed) == TYPE_DICTIONARY:
			user_data = parsed
		else:
			print("❌ Error al leer JSON. Generando nuevo archivo.")
			user_data = {
				"user": "00",
				"_id": "00",
				"money": "00000",
				"fishes": []
			}
			save_data()

func save_data():
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	file.store_string(JSON.stringify(user_data, "\t"))
	file.close()

func add_fish(raza: String):
	var fishes = user_data["fishes"]
	var nuevo_id = str(fishes.size())
	fishes.append({
		"_id": nuevo_id,
		"raza": raza
	})
	save_data()
