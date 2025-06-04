extends Node

const SAVE_PATH := "user://tank_data.json"
var tank_data := {}

func createTank(id:String):
  #se crea el tanke cuando es llamada 

  if not FileAccess.file_exists(SAVE_PATH):
    tank_data = {{
        "_id": id,
        "name": "Tank0",
        "capacity": 20,
        "cleanliness":100,
        "fishes":[],
      
    }}
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
      var tanks = tank_data.size()#aca hay que poner el id que nos pase mongo o un generador 
      print(tanks)
      tank_data.append(
        {
          "_id": id,
          "name": $"Tank{tanks}",
          "capacity": 20,
          "cleanliness":100,
          "fishes":[],
        }
      )
    save_data()
    return $"Tank{tanks}"


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