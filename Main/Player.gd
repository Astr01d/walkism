extends CharacterBody3D


var speed : float
var sprint = 1.5
const PLAYER_SPEED : float = 7
const JUMP_VELOCITY = 6
const SENSITIVITY = .15

# Get the gravity from the project settings to be synced with RigidBody nodes.
var game_gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var gravity = 0 

var mouse_input : Vector2

func _ready():
	speed = PLAYER_SPEED
	gravity = game_gravity
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	pass

func _input(event):
	
	if event is InputEventMouseMotion && Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		mouse_input.x = event.relative.y * .015
		mouse_input.y = -event.relative.x * .015
	else:
		mouse_input = Vector2.ZERO
	pass


func _process(delta):
	# Add the gravity.
	if not is_on_floor():
		gravity = lerp(game_gravity, game_gravity/2, Input.get_action_strength("ui_accept"))
		velocity.y -= gravity * delta
	
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	var controller_input_r : Vector2
	controller_input_r.y = Input.get_axis("Joypad_R_Right","Joypad_R_Left") 
	controller_input_r.x = Input.get_axis("Joypad_R_Up","Joypad_R_Down")
	
	var head_rot = controller_input_r + mouse_input 
	
	self.transform = self.transform.rotated_local(Vector3.UP, head_rot.y * SENSITIVITY)
	$Head.transform = $Head.transform.rotated_local(Vector3.LEFT, head_rot.x * SENSITIVITY)
	
	$Head.rotation.x = clamp($Head.rotation.x, deg_to_rad(-90), deg_to_rad(90))
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	speed = lerp(PLAYER_SPEED, PLAYER_SPEED * sprint, Input.get_action_strength("sprint_button"))
	
	if direction:
		velocity.x = move_toward(velocity.x, direction.x * speed, .7)
		velocity.z = move_toward(velocity.z, direction.z * speed, .7)
	else:
		velocity.x = move_toward(velocity.x, 0, .5)
		velocity.z = move_toward(velocity.z, 0, .7)
	
	
	move_and_slide()
