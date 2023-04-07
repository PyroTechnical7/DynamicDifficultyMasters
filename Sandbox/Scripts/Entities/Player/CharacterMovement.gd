extends CharacterBody2D


const SPEED = 500.0
var rotation_point
var angle = 0
var rotating = false


func get_input():
	look_at(get_global_mouse_position())
	rotation = rotation + PI/2
	
	
	var input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = input_direction * SPEED
	
	if Input.is_action_just_pressed("ui_select"):
		rotation_point = get_global_mouse_position() 
		angle = rotation_point.angle_to_point(global_position) + 0.5*PI
		rotating = true
	
	if Input.is_action_just_released("ui_select"):
		rotating = false
	
	


func _physics_process(delta):
	get_input()

	if (rotating):
		var radius = global_position.distance_to(rotation_point)
		var rotation_speed =   5
		angle += -rotation_speed * delta
		
		var offset = Vector2(sin(angle), -cos(angle)) * radius
		var pos = rotation_point + offset
		
		pos = pos - global_position
		
		if (move_and_collide(pos)): rotating = false
	
	else :
		move_and_slide()
		

		

