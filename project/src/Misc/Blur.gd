extends TextureRect

export var decreaseOpacityWithTime: bool = false
export var opacityIncreaseAmount: float = 10.0 / 100.0
export var opacityUpperBound: float = 0.85
onready var rbt: Timer =  $ReduceBlurTimer
var shouldMaxOpacity: bool = false

func _ready():
	self.modulate.a = 0
	rbt.decreaseOpacityWithTime = decreaseOpacityWithTime

func _process(delta):
	if self.shouldMaxOpacity:
		self.increaseOpacity()


func increaseOpacity():
	if self.modulate.a < opacityUpperBound:
		self.modulate.a += opacityIncreaseAmount
		print("blur opacity: ", self.modulate.a)

func maxOpacity():
	self.shouldMaxOpacity = true
