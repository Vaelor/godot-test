extends Node2D

enum DoorState {CLOSED, CLOSING, OPENING, OPEN}

export (bool) var open setget setOpen, getOpen
export (bool) var canOpen setget setCanOpen, getCanOpen
export (DoorState) var doorState setget ,getDoorState


var playerInInteractArea: bool = false


func getDoorState():
	return doorState


func setCanOpen(b):
	canOpen = b


func getCanOpen():
	return canOpen


func setOpen(b):
	if canOpen:
		open = b


func getOpen():
	return open


func setDoorState(newState) -> void:
	match newState:
		DoorState.OPEN:
			doorState = DoorState.OPENING
			$DoorAnimation.animation = 'opening'
			doorState = DoorState.OPEN
			$DoorBody/ClosedDoorCollision.disabled = true
		DoorState.CLOSED:
			doorState = DoorState.CLOSING
			$DoorAnimation.animation = 'closing'
			doorState = DoorState.CLOSED
			$DoorBody/ClosedDoorCollision.disabled = false
	$DoorAnimation.play()


func isDoorInAClosingState() -> bool:
	print((doorState == DoorState.CLOSED) or (doorState == DoorState.CLOSING))
	return (doorState == DoorState.CLOSED) or (doorState == DoorState.CLOSING)


func isDoorInAOpeningState() -> bool:
	print((doorState == DoorState.OPEN) or (doorState == DoorState.OPENING))
	return (doorState == DoorState.OPEN) or (doorState == DoorState.OPENING)


func toggleDoorState() -> void:
	if isDoorInAClosingState():
		setDoorState(DoorState.OPEN)
	elif isDoorInAOpeningState():
		setDoorState(DoorState.CLOSED)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	setDoorState(doorState)


func isDoorInteractedWith() -> void:
	if Input.is_action_just_released("ui_select") and playerInInteractArea:
		print(doorState)
		toggleDoorState()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta) -> void:
	isDoorInteractedWith()


func _on_Door_body_entered(body) -> void:
	print('enter door')
	print(body)


func _on_Door_body_exited(body) -> void:
	print('leave door')
	print(body)


func _on_DoorInteractArea_body_entered(body) -> void:
	print('enter interact area')
	if body.is_in_group('player'):
		playerInInteractArea = true


func _on_DoorInteractArea_body_exited(body) -> void:
	print('exit interact area')
	if body.is_in_group('player'):
		playerInInteractArea = false

