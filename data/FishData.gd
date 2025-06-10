extends Node
const SAVE_PATH := "user://fish_data.json"
var fish_data := []

func createFish(data):
	var time = Time.get_unix_time_from_system()
	if not FileAccess.file_exists(SAVE_PATH):
		fish_data = [{
			"id":data["id"],
			"name": data["raza"],
			"raza":data["raza"],
			"age": time,#fecha
			"gender":data["gender"],#genero
			"tier":data["tier"],#calidad
			"hunger": time,#fecha
			"mood":data["mood"],#animo -> wiki
			# "parents": [],
			}]
		save_data()
	else:
		#llamar a la funcion de addFish de tank
		var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
		var text = file.get_as_text()
		file.close()

		var parsed = JSON.parse_string(text)
		if typeof(parsed) != TYPE_ARRAY:
			print("❌ Error al leer JSON. Generando nuevo archivo.")
		else:
			fish_data = parsed
			fish_data.append(
				{
					"id":data["id"],
					"name": data["raza"],
					"raza":data["raza"],
					"age": time,#fecha
					"gender":data["gender"],#genero
					"tier":data["tier"],#calidad
					"hunger": time,#fecha
					"mood":data["mood"]#animo -> wiki
				}
			);
		save_data()

func getFishes():
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	var text = file.get_as_text()
	file.close()
	var parsed = JSON.parse_string(text)
	if typeof(parsed) != TYPE_ARRAY:
		print("❌ Error al leer JSON. Generando nuevo archivo.")
	else:
		return parsed

func getFishforId(id: String):
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	var text = file.get_as_text()
	file.close()
	var parsed = JSON.parse_string(text)
	if typeof(parsed) != TYPE_ARRAY:
		print("❌ Error al leer JSON. Generando nuevo archivo.")
	else:
		for fish in parsed:
			if fish["id"] == id:
				return fish

func editFish(id:String, data):
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	var text = file.get_as_text()
	file.close()
	var parsed = JSON.parse_string(text)
	if typeof(parsed) != TYPE_ARRAY:
		print("❌ Error al leer JSON. Generando nuevo archivo.")
	else:
		for fish in parsed:
			if fish["id"] == id:
				fish = data
				save_data()
	pass

func hungerFish(id:String):
	var time = Time.get_unix_time_from_system()
	var fish = getFishforId(id)
	var hour = fish["hunger"]
	var hunger_lost = int(time - hour)/10800
	var new_hunger = max(4 - hunger_lost, 0)#0-> con hambre || 4 -> lleno
	
	if new_hunger == 0 && (hour > (10800*4)):
		fish["hunger"] = int(hour - (10800*4))
		editFish(id, fish)
	return new_hunger

func save_data():
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	file.store_string(JSON.stringify(fish_data, "\t"))
	file.close()
