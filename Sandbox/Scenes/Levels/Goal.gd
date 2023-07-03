extends Polygon2D
var start_time
var time_taken
var DifficultyHandler
# Called when the node enters the scene tree for the first time.
@export
var nextLevel : Node2D

var next_level_resource = load("res://Scenes/Levels/level2.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	start_time = Time.get_unix_time_from_system()
	DifficultyHandler = get_tree().root.get_node("World/DifficultyHandler")
	DifficultyHandler.currentLevel = get_parent()
	DifficultyHandler.currentLevelResource = load("res://Scenes/Levels/Level1.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
		
func loadNextLevel():
	var current_level = get_parent()
	var world = current_level.get_parent()
	var bullets = get_tree().get_nodes_in_group("bullets")
	get_tree().call_group("bullets", "queue_free")
	world.remove_child(current_level)
	world.add_child(next_level_resource.instantiate())
	
func _on_area_2d_area_entered(area):
	time_taken = Time.get_unix_time_from_system() - start_time
	if(DifficultyHandler.has_method("level_cleared")):
		DifficultyHandler.level_cleared([time_taken])
	loadNextLevel()
