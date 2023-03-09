extends Area2D

signal playerHit

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(has_overlapping_bodies()):
		get_parent().queue_free()
		
		emit_signal("playerHit")
