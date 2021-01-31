extends Control


func play():
	print("Pressed play")
	get_tree().change_scene("res://src/Levels/GeneratedLevel.tscn")


func quit():
	print("Pressed quit")
	get_tree().quit()
