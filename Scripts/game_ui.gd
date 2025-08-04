extends Control
## Game UI Manager - Handles all in-game UI elements
## Currently includes: Clock system
## Future: Stress meter, travel progress, notifications, etc.

# Clock UI components
@onready var time_label = $ClockContainer/TimeLabel

# Clock system variables (10 real minutes = 75 steps of 5 game minutes each)
@export var start_time_hour: int = 9
@export var start_time_minute: int = 0
@export var end_time_hour: int = 15
@export var end_time_minute: int = 15
@export var time_step_interval: float = 8.0  # Real seconds per time step
@export var time_step_minutes: int = 5  # Game minutes per step

var current_time_minutes: float = 0.0
var total_journey_minutes: float = 0.0
var is_clock_running: bool = false
var step_timer: float = 0.0

# Signals
signal clock_started
signal clock_finished

func _ready():
	print("GameUI: Inicjalizacja interfejsu gry")
	_initialize_clock()

# === CLOCK SYSTEM ===

func _initialize_clock():
	# Convert start and end times to minutes
	current_time_minutes = start_time_hour * 60 + start_time_minute
	var end_time_minutes = end_time_hour * 60 + end_time_minute
	total_journey_minutes = end_time_minutes - current_time_minutes
	
	step_timer = 0.0
	_update_time_display()
	
	print("GameUI: Zegar skonfigurowany od %02d:%02d do %02d:%02d" % [start_time_hour, start_time_minute, end_time_hour, end_time_minute])
	print("GameUI: Zegar skacze co %d minut gry, co %.1f sekund realnych" % [time_step_minutes, time_step_interval])
	
	var total_steps = total_journey_minutes / time_step_minutes
	var total_real_time = total_steps * time_step_interval / 60.0
	print("GameUI: Łącznie %d kroków, %.1f minut realnych" % [total_steps, total_real_time])

func _process(delta):
	if not is_clock_running:
		return
	
	# Step-based time system: every time_step_interval seconds = time_step_minutes advance
	step_timer += delta
	
	# Check if it's time for the next step
	if step_timer >= time_step_interval:
		step_timer = 0.0  # Reset timer
		
		# Add time step (5 minutes)
		current_time_minutes += time_step_minutes
		
		# Update display
		_update_time_display()
		
		print("GameUI: Czas - %02d:%02d" % [
			int(current_time_minutes) / 60.0, 
			int(current_time_minutes) % 60
		])
		
		# Check if we've reached the end time
		if current_time_minutes >= end_time_hour * 60 + end_time_minute:
			stop_clock()
			clock_finished.emit()
			print("GameUI: Podróż zakończona o godzinie końcowej!")

func _update_time_display():
	var total_minutes = int(current_time_minutes)
	var hours = total_minutes / 60.0
	var minutes = total_minutes % 60
	
	if time_label:
		time_label.text = "%02d:%02d" % [int(hours), minutes]

func start_clock():
	"""Rozpoczyna działanie zegara"""
	print("GameUI: Rozpoczynanie zegara")
	is_clock_running = true
	step_timer = 0.0
	clock_started.emit()

func stop_clock():
	"""Zatrzymuje działanie zegara"""
	print("GameUI: Zatrzymywanie zegara")
	is_clock_running = false

func reset_clock():
	"""Resetuje zegar do czasu początkowego"""
	print("GameUI: Resetowanie zegara")
	current_time_minutes = start_time_hour * 60 + start_time_minute
	step_timer = 0.0
	is_clock_running = false
	_update_time_display()

# === UTILITY FUNCTIONS ===

func get_current_time_string() -> String:
	"""Zwraca aktualny czas jako string"""
	var total_minutes = int(current_time_minutes)
	var hours = total_minutes / 60.0
	var minutes = total_minutes % 60
	return "%02d:%02d" % [int(hours), minutes]

func get_time_progress() -> float:
	"""Zwraca postęp czasu (0.0 - 1.0)"""
	var time_elapsed = current_time_minutes - (start_time_hour * 60 + start_time_minute)
	return clamp(time_elapsed / total_journey_minutes, 0.0, 1.0)
