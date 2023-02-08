extends Area2D
var bullet_scene = load("res://Scenes/FriendlyBullet.tscn") 
@export
var ROTATION_SPEED = 0.5


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(has_overlapping_areas()):
		queue_free()
		
	rotation += ROTATION_SPEED * delta
			
