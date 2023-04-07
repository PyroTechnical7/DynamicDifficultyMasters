extends Area2D
var bullet_scene = load("res://Scenes/FriendlyBullet.tscn") 
@export
var ROTATION_SPEED = 2
@export
var player_bullet : Node2D
var collidable = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
		
	rotation += ROTATION_SPEED * delta

func friendly_shot():
	queue_free()
