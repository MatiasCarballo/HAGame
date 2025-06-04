extends Node

func _ready():
	$UiControlGame.connect("add_fish_requested",Callable($Tank, "_on_add_fish_requested"))
