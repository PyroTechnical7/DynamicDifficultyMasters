extends Control
var DifficultyHandler

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false
	DifficultyHandler = get_tree().root.get_node("World/DifficultyHandler")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position = get_viewport_rect().size/2

func finish():
	visible = true
	var text = DifficultyHandler.get_times()
	get_node("Label").text +="\n" + text
