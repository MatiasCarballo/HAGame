extends Node

const SAVE_PATH := "user://user_data.json"
var user_data := {}

func _ready():#cambiar esto, tiene que recargar todas las DDBB (user,tank,peces)
	load_data()

func load_data():
	var idUser = UUID.generator()
	var idTank = UUID.generator()
	if not FileAccess.file_exists(SAVE_PATH):#luego esto cambiarlo cuando inicia secion 
		TankData.createTank(idTank)
		print("📝 Archivo de datos no existe. Creando uno nuevo...")
		user_data = {
			"user": "00",
			"id": idUser,
			"money": "00000",
			"fishes": [],
			"tanks":{
				"Tank0": idTank
				}
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
			# user_data = {
			# 	"user": "00",
			# 	"_id": id,
			# 	"money": "00000",
			# 	"fishes": []
			# }
			save_data()

func newTank():
	var idTank = UUID.generator()
	var nameTank = TankData.createTank(idTank)
	var fishes = user_data["tanks"]

#func newFish(raza: String, money ):#luego esto se hara una func mas grande, controlando los peces y su calidad 
	#var idTank = UUID.generator()
	#var fishes = user_data["fishes"]
	#var nuevo_id = str(fishes.size())
	#fishes.append({
		#"_id": nuevo_id,
		#"raza": raza
	#})
	#save_data()

func save_data():
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	file.store_string(JSON.stringify(user_data, "\t"))
	file.close()
