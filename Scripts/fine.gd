extends Control

@onready var reason_options = $ReasonOptions
@onready var sum_options = $SumOptions
@onready var indicator = $Indicator
@onready var anim = $AnimationPlayer

var reason_given = false
var sum_given = false
var signed = false


func _ready() -> void: ### TEMPORARY
	start_writing()

func start_writing():
	$Ready.disabled = true
	indicator.visible = true
	indicator.position = $ReasonMarker.position
	anim.play("indicator")


func _on_reason_options_item_selected(index: int) -> void:
	reason_given = true
	check_ready()
	if sum_given == false:
		indicator.position = $SumMarker.position
	elif signed == false:
		indicator.position = $SignatureMarker.position

func _on_sum_options_item_selected(index: int) -> void:
	sum_given = true
	check_ready()
	if reason_given == false:
		indicator.position = $ReasonMarker.position
	elif signed == false:
		indicator.position = $SignatureMarker.position

func _on_sign_pressed() -> void:
	$ConductorSignature.visible = true
	signed = true
	check_ready()
	if reason_given == false:
		indicator.position = $ReasonMarker.position
	elif sum_given == false:
		indicator.position = $SumMarker.position

func check_ready():
	if reason_given and sum_given and signed:
		$Ready.disabled = false
		indicator.visible = false

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("Magnify") and $CloseInstruction.visible:
		queue_free()

func _on_ready_pressed() -> void:
	$CloseInstruction.visible = false
	$CloseLabel.visible = false
	$PassengerSignature.text = PassengerDataBus.currently_checked_passenger.full_name
	$PassengerSignature.visible = true
	PassengerDataBus.currently_checked_passenger.is_fined = true
	PassengerDataBus.currently_checked_passenger.interactive_look_remover()
	PassengerDataBus.currently_checked_passenger.hide_interaction_label()
	await get_tree().create_timer(1.5).timeout
	queue_free()
