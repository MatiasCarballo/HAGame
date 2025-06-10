extends Node

const SAVE_PATH := "user://tank_data.json"
var tank_data := []

func createTank(id:String):
  #se crea el tanke cuando es llamada 
	var time = Time.get_unix_time_from_system()
	if not FileAccess.file_exists(SAVE_PATH):
		tank_data = [{
			"id": id,
			"name": "Tank0",
			"capacity": 20,
			"cleanliness":time,
			"fishes":[]
		}]
		save_data()
	else:
		var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
		var text = file.get_as_text()
		file.close()

		var parsed = JSON.parse_string(text)
		if typeof(parsed) != TYPE_DICTIONARY:
			print("Error al parcear tank_data")
		else:
			tank_data = parsed
			var tanks = tank_data.size()
			# print(tanks)
			tank_data.append(
			  {
				"id": id,
				"name": $"Tank{tanks}",
				"capacity": 20,
				"cleanliness":100,
				"fishes":[],
			  }
			)
			save_data()
			return $"Tank{tanks}"

func addFish(id: String, raza: String, gender:String):
	var idFish = UUID.generator()
	
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	var text = file.get_as_text()
	file.close()
	var parsed = JSON.parse_string(text)
	
	
	var fishDic = FileAccess.open("res://data/fishes.json", FileAccess.READ)
	var textFish = fishDic.get_as_text()
	fishDic.close()
	var parsedFish = JSON.parse_string(textFish)
	
	if typeof(parsedFish) != TYPE_ARRAY:
		print("❌ Error al leer JSON. fish.")
		return false
	else:
		if typeof(parsed) != TYPE_ARRAY:
			print("❌ Error al leer JSON.tank.")
			return false
		else: 
			for tanks in parsed:
				
				if tanks["id"] == id:
					var fishTank = tanks["fishes"]
					fishTank.append({"id":idFish})
					tank_data = parsed
					print(tank_data)
					save_data()
					for fish in parsedFish:
						print(raza)
						if fish["raza"] == raza:
							print(fish)
							var data = {
								"id": idFish,
								"raza": raza,
								"gender": gender,
								"tier": fish["tier"],
								"mood": fish["mood"]
							}
							FishData.createFish(data)
							return true
					
	return false

func getFish(id:String):
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	var text = file.get_as_text()
	file.close()
	var parsed = JSON.parse_string(text)
	
	if typeof(parsed) != TYPE_ARRAY:
		print("❌ Error al leer JSON. fish.")
	else:
		var totalFish = []
		for tanks in parsed:
			if tanks["id"] == id:
				var fishTank = tanks["fishes"]
				for fish in fishTank:
					var dataFish = FishData.getFishforId(fish["id"])
					totalFish.append(dataFish)
		return totalFish

func infoTank(id:String):
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	var text = file.get_as_text()
	file.close()
	var parsed = JSON.parse_string(text)
	if typeof(parsed) != TYPE_DICTIONARY:
		print("Error al parcear tank_data")
	else:
		#tank_data = parsed
		for tanks in parsed:
			if tanks["id"] == id:
				return tanks
	pass


func hunger(id:String):
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	var text = file.get_as_text()
	file.close()
	var parsed = JSON.parse_string(text)
	
	if typeof(parsed) != TYPE_ARRAY:
		print("❌ Error al leer JSON. fish.")
	else:
		var hungerPointPorcent
		for tanks in parsed:
			
			if tanks["id"] == id:
				var totalFishes = tanks["fishes"].size()
				var hungerPoint = 0.0 
				var fishTank = tanks["fishes"]
				for fish in fishTank:
					hungerPoint += FishData.hungerFish(fish["id"])
				hungerPointPorcent = float(((hungerPoint / float(totalFishes * 4))*100)/100)
				return hungerPointPorcent

func clear(id:String):
	var time = Time.get_unix_time_from_system()
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	var text = file.get_as_text()
	file.close()
	var parsed = JSON.parse_string(text)
	
	if typeof(parsed) != TYPE_ARRAY:
		print("❌ Error al leer JSON. fish.")
	else:
		tank_data = parsed
		for tanks in tank_data:
			if tanks["id"] == id:
				var hour = tanks["cleanliness"]
				var timeC = int(time - hour)/3600
				var clearPointTank = clamp(timeC, 0, 12)
				if clearPointTank == 12 && (hour > (3600*12)):
					tanks["cleanliness"] = int(hour - (3600*12))
					save_data()
				var porcent = float(((float(clearPointTank) / 12.0)*100)/100)
				print(clearPointTank)
				return porcent

func save_data():
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	file.store_string(JSON.stringify(tank_data, "\t"))
	file.close()



# {  
#   "Tank0": {
#     "_id": 00,
#     "name": "Tank1",
#     "capacity": 20
#     "cleanliness":100
#     "fishes":[]  
#   }, 
#   "Tank1": {
#     "_id": 00,
#     "name": "Tank1",
#     "capacity": 20
#     "cleanliness":100
#     "fishes":[]  
#   }, 
# }
