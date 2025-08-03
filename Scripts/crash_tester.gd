extends Node
## Crash Testing and Error Simulation Examples
## Use these functions to test the logging system and crash handling

class_name CrashTester

# Test different types of logging
func test_basic_logging():
	## Test all logging levels
	Logger.debug("This is a debug message - only visible in debug builds")
	Logger.info("Game state: Everything is working normally")
	Logger.warning("Minor issue detected: Low memory warning")
	Logger.error("Problem occurred: Failed to load texture")
	Logger.critical("Critical issue: Cannot save game data")

# Test specialized logging functions
func test_game_logging():
	## Test game-specific logging functions
	Logger.log_passenger_interaction("Jan Kowalski", "ticket_check", "valid")
	Logger.log_ticket_control("Anna Nowak", true, false)
	Logger.log_stress_change(45.0, 60.0, "rude passenger")
	Logger.log_scene_transition("main_menu", "game_scene")

# Simulate different crash scenarios
func test_crash_scenarios():
	## Test crash detection and logging
	
	# Test 1: Null reference crash
	simulate_null_reference_crash()
	
	# Test 2: Array out of bounds
	simulate_array_crash()
	
	# Test 3: Division by zero
	simulate_division_crash()

func simulate_null_reference_crash():
	## Simulate a null reference error
	Logger.log_crash_data("Simulated null reference exception in test", {
		"test_type": "null_reference",
		"function": "simulate_null_reference_crash"
	})

func simulate_array_crash():
	## Simulate array bounds error
	Logger.log_crash_data("Simulated array out of bounds in test", {
		"test_type": "array_bounds",
		"array_size": 3,
		"attempted_index": 10
	})

func simulate_division_crash():
	## Simulate division by zero
	Logger.log_crash_data("Simulated division by zero in test", {
		"test_type": "division_by_zero",
		"numerator": 10,
		"denominator": 0
	})

# Performance testing
func test_performance_logging():
	## Test performance monitoring
	var start_time = Time.get_unix_time_from_system()
	
	# Simulate slow operation
	await get_tree().create_timer(0.1).timeout
	
	var end_time = Time.get_unix_time_from_system()
	var execution_time = end_time - start_time
	
	Logger.log_performance_warning("test_slow_function", execution_time)

# File system testing
func test_file_operations():
	## Test file-related crash scenarios
	# Test invalid file path
	var file = FileAccess.open("invalid://path/file.txt", FileAccess.READ)
	if file == null:
		Logger.log_error("Failed to open file: invalid path", "FILE_SYSTEM")

# Memory testing
func test_memory_issues():
	## Test memory-related problems
	Logger.info("Testing memory allocation", "MEMORY_TEST")
	
	# Simulate memory intensive operation
	var large_array = []
	for i in range(100000):
		large_array.append("Memory test string %d" % i)
	
	Logger.info("Large array created with %d elements" % large_array.size(), "MEMORY_TEST")
	
	# Clean up
	large_array.clear()
	Logger.info("Memory test completed", "MEMORY_TEST")

# Integration with existing game systems
func add_crash_testing_to_game():
	## Example of how to add crash testing to your game systems
	
	# Add crash testing hotkeys (only in debug builds)
	if OS.is_debug_build():
		Logger.info("Crash testing enabled - Press F9 for basic logging test", "CRASH_TESTER")
		
func _input(event):
	## Handle crash testing input (only in debug builds)
	if not OS.is_debug_build():
		return
		
	if Input.is_action_just_pressed("ui_accept") and Input.is_key_pressed(KEY_F9):
		Logger.info("Running crash test suite", "CRASH_TESTER")
		test_basic_logging()
		test_game_logging()
		test_performance_logging()
		
	elif Input.is_action_just_pressed("ui_accept") and Input.is_key_pressed(KEY_F10):
		Logger.warning("Running crash simulation tests", "CRASH_TESTER")
		test_crash_scenarios()

# Utility function to check log file
func check_log_file():
	## Check if logging is working by reading the log file
	var log_content = FileAccess.get_file_as_string("user://game_log.txt")
	if log_content != "":
		Logger.info("Log file contains %d characters" % log_content.length(), "LOG_CHECK")
		print("Recent log entries:")
		var lines = log_content.split("\n")
		var recent_lines = lines.slice(-5)  # Last 5 lines
		for line in recent_lines:
			if line.strip_edges() != "":
				print("  " + line)
	else:
		Logger.error("Log file is empty or unreadable", "LOG_CHECK")
