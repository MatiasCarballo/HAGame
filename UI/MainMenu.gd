extends Control

func _on_BotonJugar_pressed():
	var juego = load("res://Main/Aquarium.tscn")  # Ajustá la ruta si usás otra
	print(juego)
	get_tree().change_scene_to_packed(juego)
