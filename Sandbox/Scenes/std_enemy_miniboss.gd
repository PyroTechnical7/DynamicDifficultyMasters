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
var body
var startingHealth


# Called when the node enters the scene tree for the first time.
func _ready():
	DifficultyHandler = get_tree().root.get_node("World/DifficultyHandler")
	#DifficultyHandler.lowerSpeed.connect(setSpeedLow)
	var timer = get_node("EnemyBulletSpawner/Timer") as Timer
	health = DifficultyHandler.miniboss_health
	timer.wait_time = interval
	startingHealth = health
	body = get_node("body2")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	player = get_parent().get_parent().get_parent().get_parent().get_node("Player/CharacterBody2D")
	if(player != null):
		look_at(player.global_position)
	rotation = rotation - 0.5*PI
	
		
			
func setSpeedLow():
	get_node("EnemyBulletSpawner").SPEED = 2
	
func friendly_shot():
	health+= -1
	body.scale = Vector2( 1, float(startingHealth-health)/startingHealth)
	if(health <= 0 ):
		queue_free()
		destroyed.emit()
