extends CanvasLayer

signal start_game

onready var messageLabel := $MessageLabel
onready var scoreLabel := $ScoreLabel
onready var button := $Button
onready var messageTimer := $MessageTimer


func update_score(score):
	scoreLabel.text = str(score)

func show_message(text):
	messageLabel.text = text
	messageLabel.show()
	messageTimer.start()
	
func show_game_over():
	show_message("Game Over")
	yield(messageTimer, "timeout")
	restart_message()

func restart_message():
	messageLabel.text = "Dodge the Creeps"
	messageLabel.show()
	yield(get_tree().create_timer(1.0), "timeout")
	button.show()

func _on_MessageTimer_timeout():
	messageLabel.hide()


func _on_Button_pressed():
	messageLabel.hide()
	button.hide()
	emit_signal("start_game")
