extends Node2D

@onready var tutorial_dialogue = preload("res://Scenes/tutorial_dialogue.tscn").instantiate()
@onready var ticket_control = $ToolkitLayer/TicketControl


#func _ready() -> void:
	#await get_tree().create_timer(5).timeout
	#$KonduktorzySplashScreen.queue_free()
	#get_tree().paused = true
	#$StartMenu.visible = true
	#### set ChooChoo to Autoplay
	##await get_tree().create_timer(2).timeout
	#$MenuMusic.play()
	
#func start_dialogue():
	#get_tree().paused = false
	#$ToolkitLayer/TutorialDialogue.start_tutorial_dialogue()

func start_ticket_control():
	ticket_control.visible = true
	ticket_control.start_control()
	get_tree().get_first_node_in_group("Player").can_move = false

func end_ticket_control():
	get_tree().get_first_node_in_group("Player").can_move = true
	ticket_control.visible = false

func _input(event: InputEvent) -> void:
	if $StartMenu.visible == false and Input.is_action_just_pressed("ESC"):
		get_tree().paused = true
		$PauseMenu.visible = true
