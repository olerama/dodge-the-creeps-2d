extends Area2D

export var speed := 400.0

signal hit

var direction := Vector2.ZERO
onready var sprite := $AnimatedSprite
onready var size := get_viewport_rect().size


func _ready():
	hide()


func start_game(new_position):
	position = new_position
	show()
	sprite.animation = "right"
	sprite.frame = 0

func _process(delta):
	direction = Vector2.ZERO
	if Input.is_action_pressed("ui_right"):
		direction.x += 1
	if Input.is_action_pressed("ui_left"):
		direction.x -= 1
		
	if Input.is_action_pressed("ui_down"):
		direction.y += 1
	if Input.is_action_pressed("ui_up"):
		direction.y -= 1
		
	if direction.length() > 0:
		direction = direction.normalized()
		sprite.play()
	else:
		sprite.stop()
	
	
	if direction.x != 0:
		sprite.animation = "right"
		sprite.flip_h = direction.x < 0
		sprite.flip_v = false
	elif direction.y != 0:
		sprite.animation = "up"
		sprite.flip_v = direction.y > 0
	
	position += direction * speed * delta
	position.x = clamp(position.x, 0, size.x)
	position.y = clamp(position.y, 0, size.y)
	


func _on_Player_body_entered(body):
	hide()
	set_deferred("disabled", "true")
	emit_signal("hit")
