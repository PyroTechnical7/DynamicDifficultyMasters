extends CollisionShape2D

@export
var player : Node2D

var nextLevel

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(get_parent().get_overlapping_bodies().has(player)):
		get_tree().change_scene_to_file("res://Scenes/Levels/level2.tscn")
		
