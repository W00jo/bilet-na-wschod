extends Control

@onready var stress_bar = $StressBar
@onready var info_label = $InfoLabel
@onready var small_stress_button = $VBoxContainer/SmallStressButton
@onready var medium_stress_button = $VBoxContainer/MediumStressButton
@onready var large_stress_button = $VBoxContainer/LargeStressButton
@onready var reset_button = $VBoxContainer/ResetButton

# Arbitralne zmienne systemu stresu
var max_stress := 100.0
var current_stress := 0.0

# Tekstury do animacji migania (załadowane bezpośrednio ze sceny)
var texture_normal: Texture2D  # stressbar.png (normalny kolor)
var texture_flash: Texture2D   # stressbar_over.png (migający kolor)

# System "migania"
var is_flashing := false
var flash_timer := 0.0
var flash_duration := 0.5  # Jak długo ma migać po dodaniu stresu
var flash_interval := 0.1  # Częstotliwość migania

func _ready():
	print("DZIAŁA")
	
	_load_textures_from_scene()
	_setup_stress_bar()
	
	# Początek bez stresu (pusty pasek)
	current_stress = 0.0
	_update_visual_representation()

func _load_textures_from_scene():
	# BEZ TEGO MI NIE DZIAŁA I NIE WIEM DLACZEGO
	texture_normal = preload("res://Assets/Sprites/UIElements/stressbar.png")
	texture_flash = preload("res://Assets/Sprites/UIElements/stressbar_over.png")

func _setup_stress_bar():
	# Czekaj na załadowanie tekstur
	await get_tree().process_frame
	
	if stress_bar:
		# Ustawia pasek jak leci
		stress_bar.min_value = 0.0
		stress_bar.max_value = 100.0
		stress_bar.value = 0.0  # Początek z pustym paskiem
		stress_bar.texture_progress = texture_normal
		
		print("TextureProgressBar skonfigurowany - zakres: 0-100, wartość: ", stress_bar.value)
	
	if stress_bar.texture_under:
		print("Szerokość paska stresu: ", stress_bar.texture_under.get_width())

func _process(delta):
	# Animacjia "migania" przy "dostawaniu" stresu
	if is_flashing:
		flash_timer += delta
		
		# Interwał animacji
		var flash_cycle = fmod(flash_timer, flash_interval * 2.0)
		if flash_cycle < flash_interval:
			stress_bar.texture_progress = texture_flash  # Migający kolor
		else:
			stress_bar.texture_progress = texture_normal  # Normalny kolor
		
		# Zatrzymaj miganie po flash_duration
		if flash_timer >= flash_duration:
			_stop_flashing()
	
	# Aktualizuj etykietę informacyjną
	_update_info_label()

func _start_flashing():
	# Rozpoczyna miganie
	is_flashing = true
	flash_timer = 0.0
	print("Rozpoczęto miganie paska stresu")

func _stop_flashing():
	# Stopuje miganie
	is_flashing = false
	flash_timer = 0.0
	stress_bar.texture_progress = texture_normal
	print("Zatrzymano miganie paska stresu")

func add_stress(amount: float, reason: String = "Nieznany"):
	print("=== ZDARZENIE STRESOWE ===")
	print("Przyczyna: ", reason)
	print("Ilość stresu: ", amount)
	print("Aktualny stres przed: ", current_stress)
	
	current_stress += amount
	current_stress = min(max_stress, current_stress)
	
	print("Aktualny stres po: ", current_stress)
	print("Procent stresu: ", get_stress_percentage(), "%")
	
	# Rozpocznij miganie przy dodaniu stresu
	_start_flashing()
	
	_update_visual_representation()

func _update_visual_representation():
	# Nowy system: im więcej stresu, tym więcej wypełniony pasek
	var stress_percent = current_stress / max_stress
	
	print("Aktualizacja wizualna - Stres: %.1f%%" % [stress_percent * 100])
	
	# Ustaw wartość paska na procent stresu (0% = pusty, 100% = pełny)
	if stress_bar:
		stress_bar.value = stress_percent * 100.0

func get_stress_percentage() -> float:
	return (current_stress / max_stress) * 100.0

func is_stressed() -> bool:
	return current_stress > 0.0

func reset_stress():
	print("=== RESET STRESU ===")
	current_stress = 0.0
	_stop_flashing()  # Zatrzymaj miganie przy resecie
	_update_visual_representation()

# Obsługa przycisków (połączone przez inspector Godot)
func _on_small_stress_pressed():
	add_stress(15.0)

func _on_medium_stress_pressed():
	add_stress(25.0)

func _on_large_stress_pressed():
	add_stress(35.0)

func _on_reset_pressed():
	reset_stress()

# Aktualizuj wyświetlanie informacji
func _update_info_label():
	var status = "Psycha nie siada"
	if current_stress > 0.0:
		status = "Psycha siada"
	
	info_label.text = "Stres: %.1f%% | Status: %s" % [
		get_stress_percentage(), status
	]
