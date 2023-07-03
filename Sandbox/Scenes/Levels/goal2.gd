extends Node
var start_time
var time_taken
var DifficultyHandler
# Called when the node enters the scene tree for the first time.
@export
var nextLevel : Node2D
var enemy1
var enemy2
var enemies_defeated
var next_level_resource = load("res://Scenes/Levels/level3.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	enemies_defeated = 0
	start_time = Time.get_unix_time_from_system()
	DifficultyHandler = get_tree().root.get_node("World/DifficultyHandler")
	enemy1 = get_parent().get_node("Path2D/PathFollow2D/StdEnemy")
	enemy2 = get_parent().get_node("Path2D/PathFollow2D3/StdEnemy")
	
	enemy1.destroyed.connect(progress_level)
	enemy2.destroyed.connect(progress_level)
	
	DifficultyHandler.currentLevel = get_parent()
	
	DifficultyHandler.currentLevelResource = load("res://Scenes/Levels/level2.tscn")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func progress_level():
	enemies_defeated += 1
	if(enemies_defeated == 2): complete_level()
		
func loadNextLevel():
	var current_level = get_parent()
	var world = current_level.get_parent()
	var bullets = get_tree().get_nodes_in_group("bullets")
	DifficultyHandler.currentLevel = current_level
	get_tree().call_group("bullets", "queue_free")
	world.remove_child(current_level)
	world.add_child(next_level_resource.instantiate())
	
func complete_level():
	time_taken = Time.get_unix_time_from_system() - start_time
	if(DifficultyHandler.has_method("level_cleared")):
		DifficultyHandler.level_cleared([time_taken])
	loadNextLevel()
