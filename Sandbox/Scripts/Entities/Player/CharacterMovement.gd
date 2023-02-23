extends CharacterBody2D


const SPEED = 500.0
var rotation_point
var angle = 0


func get_input():
	look_at(get_global_mouse_position())
	rotation = rotation + PI/2
	
	
	var x_direction = Input.get_axis("ui_left", "ui_right")
	if x_direction:
		velocity.x= x_direction * SPEED
		
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	var y_direction = Input.get_axis("ui_up", "ui_down")
	if y_direction:
		velocity.y = y_direction * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
		
	velocity = velocity.normalized() * SPEED
	
	if Input.is_action_just_pressed("ui_select"):
		rotation_point = get_global_mouse_position()
		
	else:
		move_and_slide()
	


func _physics_process(delta):
	get_input()
#	if(get_slide_collision_count() > 0 ):
#		get_parent().queue_free()
	if Input.is_action_pressed("ui_select"):
		var radius = global_position.distance_to(rotation_point)
		var rotation_speed = 100
		angle += rotation_speed * delta
		
		var offset = Vector2(sin(angle), cos(angle)) * radius
		var pos = rotation_point + offset
		
		move_and_collide(pos)
		
	

	
