extends Control

onready var text: Label = $Credits
export var textSpeed: float = 0.0005

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.text.percent_visible += self.textSpeed

func _on_CreditsTimer_timeout():
	get_tree().change_scene("res://src/UI/MainMenu.tscn")
