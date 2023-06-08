extends Area2D
var bullet_scene = load("res://Scenes/FriendlyBullet.tscn")
@export
var player:Node2D
@export
var interval:float = 1
signal destroyed
var DifficultyHandler
@export
var health = 5


# Called when the node enters the scene tree for the first time.
func _ready():
	DifficultyHandler = get_node("DifficultyHandler")
	#DifficultyHandler.lowerSpeed.connect(setSpeedLow)
	var timer = get_node("EnemyBulletSpawner/Timer") as Timer
	timer.wait_time = interval
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	player = get_node("/root/level3/Player/CharacterBody2D") as Node2D
	if(player != null):
		look_at(player.global_position)
	rotation = rotation - 0.5*PI
	
		
			
func setSpeedLow():
	get_node("EnemyBulletSpawner").SPEED = 2
	
func friendly_shot():
	health+= -1
	if(health <= 0 ):
		queue_free()
		destroyed.emit()
