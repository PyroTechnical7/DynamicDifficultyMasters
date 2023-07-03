extends CharacterBody2D
var mode = "mirror"
var rotating = false
const SPEED = 500.0
var rotation_point
var angle = 0
var player
var interval
var cooled = true
var health = 10
var DifficultyHandler
var body
var startingHealth
var start_time

# Called when the node enters the scene tree for the first time.
func _ready():
	DifficultyHandler = get_tree().root.get_node("World/DifficultyHandler")
	interval = DifficultyHandler.interval
	body = get_node("body")
	startingHealth = health
	start_time = Time.get_unix_time_from_system()
	DifficultyHandler.currentLevel = get_parent()
	DifficultyHandler.currentLevelScene = load("res://Scenes/Levels/boss_level.tscn")
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	interval = DifficultyHandler.interval
	get_node("BulletSpawner2").bullet_cooldown.wait_time = interval
	get_node("BulletSpawner3").bullet_cooldown.wait_time = interval
	match(mode):
		"mirror":
			get_input()
			get_node("BulletSpawner2").set_process(false)
			get_node("BulletSpawner3").set_process(false)
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
		"extremeMirror":
			get_input()
			get_node("BulletSpawner2").set_process(true)
			get_node("BulletSpawner3").set_process(true)
			if (rotating):
				var radius = global_position.distance_to(rotation_point)
				var rotation_speed =   5
				angle += -rotation_speed * delta
				
				var offset = Vector2(sin(angle), -cos(angle)) * radius
				var pos = rotation_point + offset
				
				pos = pos - global_position
				
				if (move_and_collide(pos)): rotating = false
			else:
				move_and_slide()
				

func get_input():
	player = get_parent().get_node("Player/CharacterBody2D")
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
		health -= 1
		body.scale = Vector2( float(health)/startingHealth, float(health)/startingHealth)
		if health <= 5: mode = "extremeMirror"
		if health <= 0: win()
		
func win():
	queue_free()
	var time_taken = Time.get_unix_time_from_system() - start_time
	if(DifficultyHandler.has_method("level_cleared")):
		DifficultyHandler.level_cleared([time_taken])
	get_parent().get_node("Player/CharacterBody2D").alive = false
	get_parent().get_node("WinScreen").finish()
