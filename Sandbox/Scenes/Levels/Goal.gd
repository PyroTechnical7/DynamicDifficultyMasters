extends Polygon2D


# Called when the node enters the scene tree for the first time.
@export
var nextLevel : Node2D

var next_level_resource = load("res://Scenes/Levels/level2.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
		
func loadNextLevel():
	var current_level = get_parent()
	var world = current_level.get_parent()
	world.remove_child(current_level)
	
	world.add_child(next_level_resource.instantiate())
	
func _on_area_2d_area_entered(area):
	loadNextLevel()
