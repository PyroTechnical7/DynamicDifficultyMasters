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
var skillScore = 80
var currentLevel :Node2D
var currentLevelResource
var level_1
var lives = 3
var start_time
var file
var max_health
var dd_enabled = false
var std_health
var miniboss_health
var pity_life = false

signal lowerSpeed(newSpeed)

# Called when the node enters the scene tree for the first time.
func _ready():
	std_health = 2
	miniboss_health = 5
	interval = 2
	max_health = 3
	start_time = Time.get_unix_time_from_system()
	file = FileAccess.open("user://save_game.dat", FileAccess.WRITE)
	level_1 = load("res://Scenes/Levels/Level1.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func level_cleared(time_taken):
	if (clear_times == null):
		clear_times = [time_taken]
	else:
		clear_times.append_array(time_taken)
		
	if(pity_life): lives = lives + 1
		
	file.store_string(str(Time.get_unix_time_from_system() - start_time) + ": Level cleared\n")
	file.store_string(str("Skill score:" + str(skillScore) + "\n"))
	
func _player_hit():
	timesHit += 1
	skillScore -= 10
	check_score()
	file.store_string(str(Time.get_unix_time_from_system() - start_time) + ": Player hit\n")
		
func player_killed():
	timesKilled += 1
	skillScore -= 10
	file.store_string(str("Skill score:" + str(skillScore) + "\n"))
	check_score()
	if(lives > 0):
		lives = lives - 1
		get_parent().remove_child(currentLevel)
		get_parent().add_child(currentLevelResource.instantiate())
		get_tree().call_group("bullets", "queue_free")
		file.store_string(str(Time.get_unix_time_from_system() - start_time) + ": Player died\n")
	else:
		file.store_string(str(Time.get_unix_time_from_system() - start_time) + ": Game over\n")
		get_parent().remove_child(currentLevel)
		lives = 3
		clear_times = []
		get_parent().add_child(level_1.instantiate())
		get_tree().call_group("bullets", "queue_free")
	
func enemy_killed():
	enemiesKilled += 1
	skillScore += 10
	check_score()
	
	file.store_string(str(Time.get_unix_time_from_system() - start_time) + ": Enemy defeated\n")
	
func check_score():
	if(!dd_enabled): return
	if skillScore < 30 :
		#emit_signal("lowerSpeed", 4)
		interval = 4
		max_health = 5
		std_health = 1
		miniboss_health = 3
		pity_life = true
	elif skillScore <= 80 :
		#emit_signal("lowerSpeed", 2)
		interval = 2
		max_health = 3
		std_health = 2
		miniboss_health = 5
		pity_life = false
		
	elif skillScore <= 110 :
		#emit_signal("lowerSpeed", 1)
		interval = 1
		max_health = 3
		std_health = 3
		pity_life = false
		

func get_times():
	var text
	for i in clear_times:
		i = snapped(i, 0.001)
		if(text == null):
			text = str(i, "\n")
		else:
			text = str(text, i, "\n")
		
	return text
