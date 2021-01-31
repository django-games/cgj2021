extends AnimatedSprite

var goUp: bool = true
var upperBound: float = 0.55
var variation: float = 0.05
var lowerBound: float = 0.10

# Called when the node enters the scene tree for the first time.
func _ready():
	self.modulate.a = 0

func _process(delta):
	if self.goUp:
		self.modulate.a += self.variation
		self.goUp = self.modulate.a < self.upperBound
	else:
		self.modulate.a -= self.variation
		self.goUp = not (self.modulate.a >= self.lowerBound)
