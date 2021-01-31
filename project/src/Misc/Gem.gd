extends Area2D

export (PackedScene) var Player

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var gem_name : String
var dark_gem = preload("res://Assets/Misc/dark_gem.png")
var magenta_gem = preload("res://Assets/Misc/magenta_gem.png")
var purple_gem = preload("res://Assets/Misc/purple_gem.png")
var silver_gem = preload("res://Assets/Misc/silver_gem.png")
var yellow_gem = preload("res://Assets/Misc/yellow_gem.png")

var gem_name_texture_map = {
	"dark_gem": dark_gem,
	"magenta_gem": magenta_gem,
	"purple_gem": purple_gem,
	"silver_gem": silver_gem,
	"yellow_gem": yellow_gem
}

# Called when the node enters the scene tree for the first time.
func _ready():
	$MainSprite.set_texture(gem_name_texture_map[gem_name])
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Item_body_entered(body):
	if body.name != 'Player':
		return

	queue_free()
	body.pick_gem(gem_name)
