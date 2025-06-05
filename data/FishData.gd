extends Node
const SAVE_PATH := "user://fish_data.json"
var fish_data := []

func createFish(data):
	var time = Time.get_unix_time_from_system()
	if not FileAccess.file_exists(SAVE_PATH):
		fish_data = [{
			"id":data["id"],
			"name": data["raza"],
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
					"age": time,#fecha
					"gender":data["gender"],#genero
					"tier":data["tier"],#calidad
					"hunger": time,#fecha
					"mood":data["mood"]#animo -> wiki
				}
			);
		save_data()
  
func save_data():
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	file.store_string(JSON.stringify(fish_data, "\t"))
	file.close()
