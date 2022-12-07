extends CharacterBody2D


const SPEED = 500.0
var rotation_point


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
		
	if Input.is_action_pressed("ui_select"):
		rotate_about_point()
	else:
		move_and_slide()
	
func rotate_about_point():
	#global_position = rotation_point + (global_position - rotation_point).rotated(PI*SPEED/global_position.distance_to(rotation_point))
	var angle = SPEED/global_position.distance_to(rotation_point)
	global_position = rotation_point + (global_position - rotation_point).rotated(angle/32)
	velocity -= velocity


func _physics_process(delta):
	get_input()
#	if(get_slide_collision_count() > 0 ):
#		get_parent().queue_free()
	

	
