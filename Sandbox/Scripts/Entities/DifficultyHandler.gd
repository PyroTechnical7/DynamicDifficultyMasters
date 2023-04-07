extends Node2D
@export
var dynamicDifficulty = false
var deaths = 0
var enemiesKilled = 0
var timesHit = 0
var playerHitSignal

signal lowerSpeed(newSpeed)

# Called when the node enters the scene tree for the first time.
func _ready():
	playerHitSignal= get_node("initialEnemy")
	#playerHitSignal.connect(_player_hit())
	
func _player_hit():
	timesHit += 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if timesHit > 5 : emit_signal("lowerSpeed", 2)
		
