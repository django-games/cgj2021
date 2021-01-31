extends Control

export var textSpeed: float = 0.0005
onready var text = $Text

func _process(_delta):
	self.text.percent_visible += self.textSpeed
	print(self.text.percent_visible)

func _on_moon_press():
	print("Skipping outro...")
	return get_tree().change_scene("res://src/Levels/Dawn.tscn")

func _on_NARRATIVE_finished():
	print("Outro finished...")
	return get_tree().change_scene("res://src/Levels/Dawn.tscn")

func _on_Timer_timeout():
	print("Timer timoeut...")
	return get_tree().change_scene("res://src/Levels/Dawn.tscn")
