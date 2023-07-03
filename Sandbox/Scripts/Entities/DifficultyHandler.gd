extends Node2D
@export
var dynamicDifficulty = false
var deaths = 0
var enemiesKilled = 0
var timesHit = 0
var playerHitSignal
var clear_times: Array
var interval
var timesKilled = 0
var skillScore = 100
var currentLevel :Node2D
var currentLevelResource
var lives = 3

signal lowerSpeed(newSpeed)

# Called when the node enters the scene tree for the first time.
func _ready():
	interval = 1
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func level_cleared(time_taken):
	if (clear_times == null):
		clear_times = [time_taken]
	else:
		clear_times.append_array(time_taken)
	
func _player_hit():
	timesHit += 1
	skillScore -= 10
	print("player hit")
	check_score()
		
func player_killed():
	timesKilled += 1
	skillScore -= 10
	check_score()
	if(lives > 0):
		lives = lives - 1
		get_parent().remove_child(currentLevel)
		get_parent().add_child(currentLevelResource.instantiate())
		get_tree().call_group("bullets", "queue_free")
	else:
		get_tree().reload_current_scene()
		get_tree().call_group("bullets", "queue_free")
	
func enemy_killed():
	enemiesKilled += 1
	skillScore += 10
	check_score()
	
func check_score():
	if skillScore < 80 :
		#emit_signal("lowerSpeed", 4)
		interval = 4
	elif skillScore < 90 :
		#emit_signal("lowerSpeed", 2)
		interval = 2
		
	elif skillScore <= 100 :
		#emit_signal("lowerSpeed", 1)
		interval = 1

func get_times():
	var text
	for i in clear_times:
		i = snapped(i, 0.001)
		if(text == null):
			text = str(i, "\n")
		else:
			text = str(text, i, "\n")
		
	return text
