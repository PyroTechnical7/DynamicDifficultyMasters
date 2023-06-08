extends CharacterBody2D
var mode = "mirror"
var rotating = false
const SPEED = 500.0
var rotation_point
var angle = 0
var player
@export
var interval:float = 1
var cooled = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	match(mode):
		"mirror":
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
				

func get_input():
	player = get_node("/root/boss_level/Player/CharacterBody2D") as Node2D
	if(player != null):
		look_at(player.global_position)
	rotation = rotation + PI/2
	
	
	var input_direction = Input.get_vector("ui_right", "ui_left", "ui_down", "ui_up")
	velocity = input_direction * SPEED
	
	if Input.is_action_just_pressed("ui_select"):
		rotation_point = get_global_mouse_position() 
		angle = rotation_point.angle_to_point(global_position) + 0.5*PI
		rotating = true
	
	if Input.is_action_just_released("ui_select"):
		rotating = false

func friendly_shot():
	queue_free()
