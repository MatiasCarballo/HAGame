extends Node

const SAVE_PATH := "user://user_data.json"
var user_data := {}
var exponent: float = 2.2      # Exponente de crecimiento (difucultad)
var multiplier: float = 20.0   # Multiplicador base para escalar XP ( xp_next = multiplier * level^exponent)(20*(2^2)=80_exp)

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
			"exp":0,
			"id": idUser,
			"starsCoins": 0,
			"perlsCoins": 0, 
			"stars": 0,
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
			save_data()
		else:
			print("❌ Error al leer JSON. Generando nuevo archivo.")

func editBasicDataUser(key:String, data):
	match key:
		"user":
			user_data["name"] = data["name"]
			save_data()
			pass
		"starsCoins":
			user_data["starsCoins"] += int(data["starsCoins"])
			save_data()
			pass
		_:
			print("no valido")
	pass

func getLevelAndExp()-> Dictionary:
	var lvl = 1
	var xp = user_data["exp"]
	while xp >= calcForLvl(lvl):
		lvl += 1
	if xp > 0:
		var porcent: float = round(float(xp) / float(calcForLvl(lvl))*100)/100
		return {"lvl":lvl, "porcent":porcent}
	else:
		return{"lvl":lvl, "porcent":0}

func calcForLvl(lvl):
	return int(ceil(multiplier * pow(lvl, exponent)))

func save_data():
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	file.store_string(JSON.stringify(user_data, "\t"))
	file.close()
