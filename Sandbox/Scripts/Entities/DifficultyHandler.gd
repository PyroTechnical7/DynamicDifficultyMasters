extends Node2D
@export
var dynamicDifficulty = false
var deaths = 0
var enemiesKilled = 0
var timesHit = 0
var playerHitSignal
var clear_times: Array
var interval

signal lowerSpeed(newSpeed)

# Called when the node enters the scene tree for the first time.
func _ready():
	interval = 1
	
func level_cleared(time_taken):
	clear_times.append_array(time_taken)
	pass
	
func _player_hit():
	timesHit += 1
	print("player hit")
	if timesHit > 4 :
		emit_signal("lowerSpeed", 4)
		interval = 4
	elif timesHit > 2 :
		emit_signal("lowerSpeed", 2)
		interval = 2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
		
