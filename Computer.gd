extends Area2D

export (string) 

var playerInInteractArea: bool = false
var playerUsingComputer: bool = false

func isComputerInteractedWith() -> void:
	if Input.is_action_just_released("ui_select") and playerInInteractArea:
		if not playerUsingComputer:
			toggleConsole()


func _ready():
	Console.register('callPhone', { # Command name
		'description': 'Calls a phone', # TODO arguments etc...
		'target': [self, 'callPhone']
	})
	# Remove the basecommand quit, we don't want the app to close
	Console.unregister('quit')
	Console.register('quit', { # Command name
		'description': 'Exits the computer',
		'target': [self, 'toggleConsole']
	})


func toggleConsole() -> void:
	playerUsingComputer = !playerUsingComputer
	Console.toggleConsole()


func callPhone():
	Console.writeLine('Calling.... Please hold the line.')


func _process(delta):
	isComputerInteractedWith()


func _on_Computer_body_entered(body):
	print('exit interact area')
	if body.is_in_group('player'):
		playerInInteractArea = true
	print(body)



func _on_Computer_body_exited(body):
	print('exit interact area')
	if body.is_in_group('player'):
		playerInInteractArea = false
	print(body)

