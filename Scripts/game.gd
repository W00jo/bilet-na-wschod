extends Node2D

@onready var tutorial_dialogue = preload("res://Scenes/tutorial_dialogue.tscn").instantiate()
@onready var ticket_control = $ToolkitLayer/TicketControl
########################################
## set KnduktorzySplashScreen visible
## set StartScreen visible
func _ready() -> void:
	# Log game initialization
	Logger.info("Game scene initializing", "GAME_MANAGER")
	
	# Enable crash testing in debug builds
	if OS.is_debug_build():
		var crash_tester = CrashTester.new()
		add_child(crash_tester)
		crash_tester.add_crash_testing_to_game()
	
	get_tree().paused = true
	await get_tree().create_timer(5).timeout
	
	Logger.info("Splash screen timeout completed", "GAME_MANAGER")
	$KonduktorzySplashScreen.queue_free()
	$StartMenu.visible = true
	### set ChooChoo to Autoplay
	$MenuMusic.play()
	Logger.info("Menu music started", "AUDIO")
	
	#start_tutorial()
	
#func start_dialogue():
	#get_tree().paused = false
	#$ToolkitLayer/TutorialDialogue.start_tutorial_dialogue()
	#
######################################

func disable_player_movement():
	Logger.debug("Disabling player movement", "PLAYER_CONTROL")
	get_tree().get_first_node_in_group("Player").can_move = false
	get_tree().get_first_node_in_group("Player").get_node('WalkSFX').stop()

func enable_player_movement():
	Logger.debug("Enabling player movement", "PLAYER_CONTROL")
	get_tree().get_first_node_in_group("Player").can_move = true

func start_ticket_control():
	ticket_control.visible = true
	ticket_control.start_control()
	disable_player_movement()

func end_ticket_control():
	enable_player_movement()
	ticket_control.visible = false

func _input(event: InputEvent) -> void:
	if $StartMenu.visible == false and Input.is_action_just_pressed("ESC"):
		get_tree().paused = true
		$PauseMenu.visible = true
