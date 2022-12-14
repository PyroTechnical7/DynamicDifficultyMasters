extends Node2D
@export
var SPEED = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += Vector2(SPEED,0).rotated(rotation)
<<<<<<< Updated upstream:Sandbox/Bullet.gd
=======


func _on_bullet_hitbox_body_entered(body):
	queue_free() # Replace with function body.
>>>>>>> Stashed changes:Sandbox/Scripts/Bullets/Bullet.gd
