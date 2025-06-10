extends Node

signal add_fish_requested
@onready var stars_coins: Label = $PanelContainer/PanelContainer/TopPanel/PanelContainer2/barTop/moneys/goldMoney/ColorRect/starsCoins
@onready var perls_money: Label = $PanelContainer/PanelContainer/TopPanel/PanelContainer2/barTop/moneys/perlsMoney/ColorRect/perlsMoney
@onready var stars_money: Label = $PanelContainer/PanelContainer/TopPanel/PanelContainer2/barTop/moneys/starsMoney/ColorRect/starsMoney
@onready var level: Label = $PanelContainer/PanelContainer/TopPanel/levelNum/Level
@onready var progress_bar_level: ProgressBar = $PanelContainer/PanelContainer/TopPanel/PanelContainer2/barTop/barlevel/ProgressBarLevel
@onready var expLabel: Label = $PanelContainer/PanelContainer/TopPanel/PanelContainer2/barTop/barlevel/ProgressBarLevel/HBoxContainer/exp
@onready var progress_bar_hunger: ProgressBar = $PanelContainer/PanelContainer/TopPanel/PanelContainer2/barbottom/States/food/ProgressBarHunger
@onready var progress_bar_clear: ProgressBar = $PanelContainer/PanelContainer/TopPanel/PanelContainer2/barbottom/States/clean/ProgressBarClear

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	#FishData.hungreFish("68422c260033ae2fe58ce085")
	
	progress_bar_hunger.value = TankData.hunger(UserData.user_data["tanks"]["Tank0"])
	progress_bar_clear.value = TankData.clear(UserData.user_data["tanks"]["Tank0"])
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var data = UserData.user_data
	var exp = UserData.getLevelAndExp()
	
	expLabel.text= str(int(data["exp"]))
	stars_coins.text = str(int(data["starsCoins"]))
	perls_money.text =str(int(data["perlsCoins"]))
	stars_money.text =str(int(data["stars"]))
	level.text = str(int(exp["lvl"]))
	progress_bar_level.value = exp["porcent"]
	pass


func _on_add_fish() -> void:
	
	emit_signal("add_fish_requested")
	print("llego un nuevo vecino...")
	


func _on_add_food_fish() -> void:
	await UserData.editBasicDataUser("starsCoins", {"starsCoins":100})
	print("llego la comidaaa")
	pass # Replace with function body.
