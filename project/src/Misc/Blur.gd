extends TextureRect

export var decreaseOpacityWithTime: bool = false
export var opacityIncreaseAmount: float = 10.0 / 100.0
onready var rbt: Timer =  $ReduceBlurTimer

func _ready():
	self.modulate.a = 0
	rbt.decreaseOpacityWithTime = decreaseOpacityWithTime
	self.increaseOpacity()

func increaseOpacity():
	self.modulate.a += opacityIncreaseAmount
	print(self.modulate.a)
