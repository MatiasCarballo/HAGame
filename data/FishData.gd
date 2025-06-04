extends Node
const SAVE_PATH := "user://fish_data.json"
var fish_data := {} 

func createFish(id:String, _phaders):
  if not FileAccess.file_exists(SAVE_PATH):
    fish_data = {
      ñ
    }
  else
  passñ