extends Node

const SAVE_PATH := "user://tank_data.json"
var tank_data := []

func createTank(id:String):
  #se crea el tanke cuando es llamada 
	if not FileAccess.file_exists(SAVE_PATH):
		tank_data = [{
			"id": id,
			"name": "Tank0",
			"capacity": 20,
			"cleanliness":100,
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
