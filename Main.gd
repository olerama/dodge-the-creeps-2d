extends Node

export var mob_scene: PackedScene
onready var start_position := $Position2D
onready var player := $Player
onready var hud := $HUD

onready var mob_timer := $MobTimer
onready var score_timer := $ScoreTimer

onready var spawn := $MobPath/MobSpawnLocation

onready var music := $Music
onready var death_sound := $DeathSound

var score := 0

func _ready():
	randomize()

func _on_MobTimer_timeout():
	spawn.unit_offset = randf()
	
	var mob := mob_scene.instance()	
	add_child(mob)
	
	mob.position = spawn.position
	
	var direction = spawn.rotation + PI /2
	direction += rand_range(-PI / 4, PI / 4)
	
	mob.rotation = direction
	
	var velocity = Vector2(rand_range(mob.min_speed, mob.max_speed), 0)
	mob.linear_velocity = velocity.rotated(direction)


func _on_HUD_start_game():
	player.start_game(start_position.position)
	mob_timer.start()
	score_timer.start()
	score = 0
	music.play()
	


func _on_Player_hit():
	mob_timer.stop()
	get_tree().call_group("mobs", "queue_free")
	hud.show_game_over()
	score_timer.stop()
	music.stop()
	death_sound.play()


func _on_ScoreTimer_timeout():
	score += 1
	hud.update_score(score)
