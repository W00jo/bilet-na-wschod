extends Control

func _ready() -> void:
	var birth_date = "15 kwi 69r."
	var short_date = birth_date.erase(birth_date.length()-4, 4)
	var mistake_rate = 1
	var new_birth_year
	if short_date.ends_with("sty ") or short_date.ends_with("lut ") or short_date.ends_with("mar "):
		new_birth_year = 35 + mistake_rate
	else:
		new_birth_year = 34 + mistake_rate
	var new_date = short_date + str(new_birth_year) + "r."
	print(new_date)



func _on_timer_timeout() -> void:
	$AnimationPlayer.play("wipe")
	
