extends Node2D

var bullet_scene = load("res://Scenes/FriendlyBullet.tscn") 
var shooter
var bullet_cooldown
var cooled = true


# Called when the node enters the scene tree for the first time.
func _ready():
	shooter = get_parent()
	bullet_cooldown = get_node("bullet_cooldown")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("ui_select_point") && cooled:
		var bullet_instance = bullet_scene.instantiate()
		shooter.get_parent().add_child(bullet_instance)
		bullet_instance.global_position = global_position
		bullet_instance.global_rotation = global_rotation - PI/2
		
		bullet_cooldown.start()
		cooled = false



func _on_bullet_cooldown_timeout():
	cooled = true
