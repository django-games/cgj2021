extends Control

export var textSpeed: float = 0.00035
onready var text = $Text

func _process(_delta):
	self.text.percent_visible += self.textSpeed
	print(self.text.percent_visible)

func _on_moon_press():
	print("Skipping intro...")
	return get_tree().change_scene("res://src/Levels/GeneratedLevel.tscn")

func _on_NARRATIVE_finished():
	print("Intro finished...")
	return get_tree().change_scene("res://src/Levels/GeneratedLevel.tscn")


func _on_Timer_timeout():
	print("Timer timoeut...")
	return get_tree().change_scene("res://src/Levels/GeneratedLevel.tscn")
