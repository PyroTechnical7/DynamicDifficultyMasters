extends Node2D
@export
var SPEED = 600

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("bullets")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += Vector2(SPEED*delta,0).rotated(rotation)
	
	# Unrender if offscreen
	if(global_position.x < -5 || global_position.y < -5 || global_position.x > 2000 || global_position.y > 1250) :
		queue_free()
	

func _on_bullet_hitbox_area_entered(area):
	if(area.has_method("friendly_shot")):
		area.friendly_shot()
		queue_free()



func _on_bullet_hitbox_body_entered(body):
	if(body.has_method("friendly_shot")):
		body.friendly_shot()
		queue_free()
		print("hit")
#	if(body.get("uncollidable")):
#		queue_free() 
