extends Area2D
var bullet_scene = load("res://Scenes/FriendlyBullet.tscn") 
@export
var ROTATION_SPEED = 2
@export
var player_bullet : Node2D
var collidable = false
@export
var interval:float = 2
var DifficultyHandler
var health = 3
var body
var startingHealth

signal destroyed


# Called when the node enters the scene tree for the first time.
func _ready():
	var timer = get_node("Timer") as Timer
	
	DifficultyHandler = get_tree().root.get_node("World/DifficultyHandler")
	interval = DifficultyHandler.interval * 2
	timer.wait_time = interval
	body = get_node("CollisionShape2D/Body") as Node2D
	startingHealth = health


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
		
	rotation += ROTATION_SPEED * delta

func friendly_shot():
	health -= 1
	body.scale = Vector2( float(health)/startingHealth, float(health)/startingHealth)
	if health <= 0:
		destory()
		
func destory():
	queue_free()
	destroyed.emit()
	if(DifficultyHandler.has_method("enemy_killed")):
			DifficultyHandler.enemy_killed()
