extends MarginContainer

@export var text:String = "Enter text"

func _process(delta: float) -> void:
	$MarginContainer/Label.text = text
