extends Node
## Enhanced Logging System for Bilet na Wschód
## Provides comprehensive logging for debugging, crash analysis, and game monitoring

class_name Logger

signal log_written(level: LogLevel, message: String)

enum LogLevel {
	DEBUG = 0,    # Detailed information for debugging
	INFO = 1,     # General information about game flow
	WARNING = 2,  # Something unexpected but not critical
	ERROR = 3,    # Error that might affect functionality
	CRITICAL = 4  # Critical error that might crash the game
}

# Configuration
const LOG_FILE_PATH = "user://game_log.txt"
const MAX_LOG_FILE_SIZE = 1024 * 1024 * 5  # 5MB
const BACKUP_LOG_FILE_PATH = "user://game_log_backup.txt"

# Internal state
static var _instance: Logger
var _log_file: FileAccess
var _session_id: String
var _startup_time: String

func _init():
	if _instance == null:
		_instance = self
		_startup_time = Time.get_datetime_string_from_system()
		_session_id = generate_session_id()
		_setup_logging()
	else:
		push_warning("Logger singleton already exists!")

func _ready():
	# Log the game startup
	log_info("=== BILET NA WSCHÓD - GAME STARTED ===")
	log_info("Session ID: " + _session_id)
	log_info("Startup Time: " + _startup_time)
	log_info("Godot Version: " + Engine.get_version_info().string)
	log_info("Platform: " + OS.get_name())
	
	# Connect to tree signals for crash detection
	get_tree().tree_exiting.connect(_on_game_exit)

func _setup_logging():
	"""Initialize the logging system"""
	# Check if log file is too large and backup if needed
	_manage_log_file_size()
	
	# Open log file in append mode
	_log_file = FileAccess.open(LOG_FILE_PATH, FileAccess.WRITE)
	if _log_file == null:
		push_error("Failed to open log file: " + LOG_FILE_PATH)
		return
	
	# Move to end of file for appending
	_log_file.seek_end()

func _manage_log_file_size():
	"""Backup and reset log file if it gets too large"""
	if FileAccess.file_exists(LOG_FILE_PATH):
		var file_size = FileAccess.get_file_as_bytes(LOG_FILE_PATH).size()
		if file_size > MAX_LOG_FILE_SIZE:
			# Backup current log
			var backup_file = FileAccess.open(BACKUP_LOG_FILE_PATH, FileAccess.WRITE)
			if backup_file:
				var current_content = FileAccess.get_file_as_string(LOG_FILE_PATH)
				backup_file.store_string(current_content)
				backup_file.close()
			
			# Clear current log
			var clear_file = FileAccess.open(LOG_FILE_PATH, FileAccess.WRITE)
			if clear_file:
				clear_file.store_line("=== LOG FILE RESET - PREVIOUS LOG BACKED UP ===")
				clear_file.close()

func generate_session_id() -> String:
	"""Generate a unique session ID for this game run"""
	var timestamp = Time.get_unix_time_from_system()
	var random_part = randi() % 10000
	return "SESSION_%d_%04d" % [timestamp, random_part]

# Main logging functions
func log_debug(message: String, context: String = ""):
	"""Log debug information (only in debug builds)"""
	if OS.is_debug_build():
		_write_log(LogLevel.DEBUG, message, context)

func log_info(message: String, context: String = ""):
	"""Log general information"""
	_write_log(LogLevel.INFO, message, context)

func log_warning(message: String, context: String = ""):
	"""Log warnings"""
	_write_log(LogLevel.WARNING, message, context)

func log_error(message: String, context: String = ""):
	"""Log errors"""
	_write_log(LogLevel.ERROR, message, context)

func log_critical(message: String, context: String = ""):
	"""Log critical errors"""
	_write_log(LogLevel.CRITICAL, message, context)

# Specialized logging functions for game events
func log_passenger_interaction(passenger_name: String, action: String, result: String = ""):
	"""Log passenger interactions for gameplay analysis"""
	var message = "Passenger: %s | Action: %s" % [passenger_name, action]
	if result != "":
		message += " | Result: " + result
	log_info(message, "PASSENGER_SYSTEM")

func log_ticket_control(passenger_name: String, ticket_valid: bool, document_valid: bool):
	"""Log ticket control events"""
	var message = "Control: %s | Ticket: %s | Document: %s" % [
		passenger_name, 
		"VALID" if ticket_valid else "INVALID",
		"VALID" if document_valid else "INVALID"
	]
	log_info(message, "TICKET_CONTROL")

func log_stress_change(old_value: float, new_value: float, reason: String):
	"""Log stress level changes"""
	var change = new_value - old_value
	var direction = "+" if change > 0 else ""
	var message = "Stress: %.1f %s%.1f = %.1f | Reason: %s" % [
		old_value, direction, change, new_value, reason
	]
	log_info(message, "STRESS_SYSTEM")

func log_scene_transition(from_scene: String, to_scene: String):
	"""Log scene changes"""
	log_info("Scene transition: %s -> %s" % [from_scene, to_scene], "SCENE_MANAGER")

func log_performance_warning(function_name: String, execution_time: float):
	"""Log performance issues"""
	if execution_time > 0.016:  # More than one frame at 60 FPS
		log_warning("Performance issue in %s: %.3f seconds" % [function_name, execution_time], "PERFORMANCE")

# Error handling and crash detection
func log_exception(error_message: String, stack_trace: Array = []):
	"""Log exceptions with stack trace"""
	log_critical("EXCEPTION: " + error_message, "EXCEPTION")
	for i in range(stack_trace.size()):
		log_critical("  Stack[%d]: %s" % [i, str(stack_trace[i])], "STACK_TRACE")

func log_crash_data(crash_reason: String, game_state: Dictionary = {}):
	"""Log crash information for debugging"""
	log_critical("=== GAME CRASH DETECTED ===", "CRASH")
	log_critical("Reason: " + crash_reason, "CRASH")
	log_critical("Session ID: " + _session_id, "CRASH")
	
	# Log game state if provided
	for key in game_state:
		log_critical("State[%s]: %s" % [key, str(game_state[key])], "CRASH_STATE")
	
	# Force flush to ensure crash data is written
	if _log_file:
		_log_file.flush()

# Internal logging implementation
func _write_log(level: LogLevel, message: String, context: String = ""):
	"""Internal function to write log entries"""
	if not _log_file:
		push_error("Log file not available")
		return
	
	var timestamp = Time.get_datetime_string_from_system()
	var level_name = LogLevel.keys()[level]
	var context_part = ("[%s] " % context) if context != "" else ""
	
	var log_entry = "[%s] [%s] %s%s" % [timestamp, level_name, context_part, message]
	
	# Write to file
	_log_file.store_line(log_entry)
	_log_file.flush()  # Ensure immediate write
	
	# Also print to console in debug builds
	if OS.is_debug_build():
		print(log_entry)
	
	# Emit signal for UI or other systems
	log_written.emit(level, message)

# Cleanup and shutdown
func _on_game_exit():
	"""Called when game is shutting down"""
	log_info("=== GAME SHUTTING DOWN ===")
	log_info("Session ended normally")
	_cleanup()

func _cleanup():
	"""Clean up resources"""
	if _log_file:
		_log_file.close()
		_log_file = null

func _exit_tree():
	"""Godot cleanup"""
	_cleanup()

# Static access functions
static func get_instance() -> Logger:
	"""Get the logger singleton instance"""
	return _instance

static func debug(message: String, context: String = ""):
	"""Static debug logging"""
	if _instance:
		_instance.log_debug(message, context)

static func info(message: String, context: String = ""):
	"""Static info logging"""
	if _instance:
		_instance.log_info(message, context)

static func warning(message: String, context: String = ""):
	"""Static warning logging"""
	if _instance:
		_instance.log_warning(message, context)

static func error(message: String, context: String = ""):
	"""Static error logging"""
	if _instance:
		_instance.log_error(message, context)

static func critical(message: String, context: String = ""):
	"""Static critical logging"""
	if _instance:
		_instance.log_critical(message, context)
