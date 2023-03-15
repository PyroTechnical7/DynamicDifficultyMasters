extends Node2D
@export
var SPEED = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += Vector2(SPEED,0).rotated(rotation)
	

func _on_bullet_hitbox_area_entered(area):
	if(area.has_method("enemy_shot")):
		area.enemy_shot()
		queue_free()
	


func _on_bullet_hitbox_body_entered(body):
	if(body.has_method("enemy_shot")):
		body.enemy_shot()
		queue_free() # Replace with function body.
