extends CharacterBody3D


var speed : float
var acceleration : float
var sprint = 1.5
const PLAYER_SPEED : float = 7
const JUMP_VELOCITY = 7 
const SENSITIVITY = .10

# Get the gravity from the project settings to be synced with RigidBody nodes.
var game_gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var gravity = 0 
var direction : Vector3
var keyboard_input : Vector2
var controller_input : Vector2
var input_damping = .25

var mouse_input : Vector2

func _ready():
	
	speed = PLAYER_SPEED
	gravity = game_gravity
	
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	floor_block_on_wall = true
	
	pass

func _input(event):
	#	mouse viewing stuff
	if event is InputEventMouseMotion && Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		mouse_input.x += event.relative.y * .015
		mouse_input.y += -event.relative.x * .015
	
	pass


func _process(delta):
#	gravity stuff
	if not is_on_floor():
		gravity = lerp(game_gravity, game_gravity/2, Input.get_action_strength("ui_accept"))
		velocity.y -= gravity * delta
	velocity.y = clamp(velocity.y, -JUMP_VELOCITY * 3, JUMP_VELOCITY)
#	jump stuff

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
#	controller viewing stuff

	var controller_input_r : Vector2
	controller_input_r.y = Input.get_axis("Joypad_R_Right","Joypad_R_Left")
	controller_input_r.x = Input.get_axis("Joypad_R_Up","Joypad_R_Down")
#	magic number hell
	controller_input_r = (controller_input_r.limit_length(.2) * 5) * .7
	print("view", controller_input_r)
	
#	combining mouse n controller meow
	var head_rot = controller_input_r + mouse_input 
	
#	applying head and cam rotation
	self.transform = self.transform.rotated_local(Vector3.UP, head_rot.y * SENSITIVITY)
	$Head.transform = $Head.transform.rotated_local(Vector3.LEFT, head_rot.x * SENSITIVITY)
	
#	resetting the mouse input
	mouse_input = Vector2.ZERO
	
#	clamping head rotation meow
	$Head.rotation.x = clamp($Head.rotation.x, deg_to_rad(-90), deg_to_rad(90))
	
	
	var input_dir : Vector2
	var target_controller_input : Vector2
	
	var target_kb_input : Vector2
	
#	read controller input
	target_controller_input = Input.get_vector("Joypad_L_Left", "Joypad_L_Right", "Joypad_L_Up", "Joypad_L_Down")
#	read keyboard input
	target_kb_input = Input.get_vector("Keyboard_L_Left", "Keyboard_L_Right", "Keyboard_L_Up", "Keyboard_L_Down")
	
	input_damping = lerp(.3, .1 , !is_on_floor())
	
	keyboard_input = lerp(keyboard_input, target_kb_input, input_damping)
	
	controller_input = lerp(controller_input, target_controller_input, input_damping)
	
	input_dir = (controller_input.limit_length(.3) * (1 / .3)) + keyboard_input.limit_length(1.0)
	
	print(input_dir)
	
	if (target_kb_input or controller_input):
		direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y))
		
	
	speed = lerp(PLAYER_SPEED, PLAYER_SPEED * sprint, Input.get_action_strength("sprint_button"))
	
	if (target_kb_input or controller_input):
		acceleration = move_toward(acceleration, speed, .9)
	else:
		acceleration = move_toward(acceleration, 0, .7)
		pass
	
	velocity.x = direction.x * acceleration
	velocity.z = direction.z * acceleration
	
	move_and_slide()
