extends Control


func play():
	print("Pressed play")
	get_tree().change_scene("res://src/UI/Intro.tscn")


func quit():
	print("Pressed quit")
	get_tree().quit()
