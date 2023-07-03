extends Label
var DifficultyHandler

# Called when the node enters the scene tree for the first time.
func _ready():
	DifficultyHandler = get_tree().root.get_node("World/DifficultyHandler")
	text = str(DifficultyHandler.lives)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position = get_parent().get_node("CharacterBody2D").position
	position.y += 60
	position.x += -10

func _on_timer_timeout():
	visible = false
