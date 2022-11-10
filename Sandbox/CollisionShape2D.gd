extends CollisionShape2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if Input.is_action_just_pressed("ui_select_point"):
		shoot()
		print(global_position)
		

func shoot():
	var bullet = preload("res://Bullet.tscn")
	var bullet_instance = bullet.instantiate()
	bullet_instance.rotation = rotation
	bullet_instance.position = global_position
	print(position)
	get_parent().get_parent().add_child(bullet_instance)
