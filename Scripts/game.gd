extends Node2D

@onready var tutorial_dialogue = preload("res://Scenes/tutorial_dialogue.tscn").instantiate()
@onready var ticket_control = $ToolkitLayer/TicketControl
@onready var clock_ui = $HUD/GameUI
########################################
## set KnduktorzySplashScreen visible
## set StartScreen visible
func _ready() -> void:
	get_tree().paused = true
	await get_tree().create_timer(5).timeout
	$KonduktorzySplashScreen.queue_free()
	$StartMenu.visible = true
	### set ChooChoo to Autoplay
	$MenuMusic.play()
	
	#start_tutorial()

func start_clock_after_tutorial():
	"""Called when tutorial is completed to start the game clock"""
	if clock_ui:
		print("Game: Tutorial completed - starting game clock!")
		clock_ui.start_clock()
	else:
		print("Game: Error - clock_ui not found!")
	
#func start_dialogue():
	#get_tree().paused = false
	#$ToolkitLayer/TutorialDialogue.start_tutorial_dialogue()
	#
######################################

func disable_player_movement():
	get_tree().get_first_node_in_group("Player").can_move = false
	get_tree().get_first_node_in_group("Player").get_node('WalkSFX').stop()

func enable_player_movement():
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
