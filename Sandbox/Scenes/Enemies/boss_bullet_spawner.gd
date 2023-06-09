extends Node2D
var bullet_scene = load("res://Scenes/EnemyBullet.tscn")
var cooled = true
var bullet_cooldown

# Called when the node enters the scene tree for the first time.
func _ready():
	bullet_cooldown = get_node("bullet_cooldown")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if cooled:
		var bullet_instance = bullet_scene.instantiate()
		get_tree().root.add_child(bullet_instance)
		bullet_instance.global_position = global_position
		bullet_instance.global_rotation = global_rotation - PI/2
				
		bullet_cooldown.start()
		cooled = false



func _on_bullet_cooldown_timeout():
	cooled = true
