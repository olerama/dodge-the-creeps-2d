extends RigidBody2D

onready var sprite := $AnimatedSprite
export var min_speed := 150
export var max_speed := 250

func _ready():
	randomize()
	sprite.play()
	var mob_types = sprite.frames.get_animation_names()
	sprite.animation = mob_types[randi() % mob_types.size()]


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
