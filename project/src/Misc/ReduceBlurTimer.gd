extends Timer

onready var blur: TextureRect = get_parent()
export var opacityDecreaseAmount: float = 5 / 100.0
export var opacityThreshold: float = 15.0 / 100.0
export var decreaseOpacityWithTime: bool = true

func _on_ReduceBlurTimer_timeout():
	var opacity: float = blur.modulate.a
	
	if decreaseOpacityWithTime and opacity > opacityThreshold:
		blur.modulate.a -= opacityDecreaseAmount
		print("adjusting opacity to ", blur.modulate.a)

