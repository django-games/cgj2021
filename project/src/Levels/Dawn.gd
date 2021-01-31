extends Control

onready var text: Label = $Credits
export var textSpeed: float = 0.0005

func _ready():
	self.text.percent_visible = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	self.text.percent_visible += self.textSpeed

func _on_CreditsTimer_timeout():
	get_tree().change_scene("res://src/UI/MainMenu.tscn")
