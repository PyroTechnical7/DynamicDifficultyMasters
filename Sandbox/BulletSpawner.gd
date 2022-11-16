extends Node2D

var bullet_scene = load("res://FriendlyBullet.tscn") 
var shooter


# Called when the node enters the scene tree for the first time.
func _ready():
	shooter = get_parent()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_select_point"):
		var bullet_instance = bullet_scene.instantiate()
		shooter.get_parent().add_child(bullet_instance)
		bullet_instance.global_position = global_position
		bullet_instance.global_rotation = global_rotation - PI/2

