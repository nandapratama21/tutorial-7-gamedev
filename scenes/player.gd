extends CharacterBody3D

@export var speed: float = 10.0
@export var sprint_speed: float = 16.0
@export var crouch_speed: float = 5.0
@export var acceleration: float = 5.0
@export var gravity: float = 9.8
@export var jump_power: float = 5.0
@export var crouch_jump_power: float = 3.0  # Reduced jump power when crouching
@export var mouse_sensitivity: float = 0.3

@onready var head: Node3D = $Head
@onready var camera: Camera3D = $Head/Camera3D
@onready var collision_shape: CollisionShape3D = $CollisionShape3D
@onready var mesh_instance: MeshInstance3D = $MeshInstance3D

var camera_x_rotation: float = 0.0
var is_crouching: bool = false
var default_height: float = 2.0
var crouch_height: float = 1.0

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	default_height = collision_shape.shape.height

func _input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		head.rotate_y(deg_to_rad(-event.relative.x * mouse_sensitivity))
		var x_delta = event.relative.y * mouse_sensitivity
		camera_x_rotation = clamp(camera_x_rotation + x_delta, -90.0, 90.0)
		camera.rotation_degrees.x = -camera_x_rotation

func _physics_process(delta):
	var movement_vector = Vector3.ZERO

	if Input.is_action_pressed("movement_forward"):
		movement_vector -= head.basis.z
	if Input.is_action_pressed("movement_backward"):
		movement_vector += head.basis.z
	if Input.is_action_pressed("movement_left"):
		movement_vector -= head.basis.x
	if Input.is_action_pressed("movement_right"):
		movement_vector += head.basis.x

	movement_vector = movement_vector.normalized()
	
	# Handle crouching
	if Input.is_action_just_pressed("crouch"):
		toggle_crouch()
	
	# Determine speed based on sprint or crouch
	var current_speed = speed
	if Input.is_action_pressed("sprint") and !is_crouching:
		current_speed = sprint_speed
	elif is_crouching:
		current_speed = crouch_speed

	velocity.x = lerp(velocity.x, movement_vector.x * current_speed, acceleration * delta)
	velocity.z = lerp(velocity.z, movement_vector.z * current_speed, acceleration * delta)

	# Apply gravity
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Jumping - now allowed while crouching but with reduced power
	if Input.is_action_just_pressed("jump") and is_on_floor():
		if is_crouching:
			velocity.y = crouch_jump_power
		else:
			velocity.y = jump_power

	move_and_slide()

func toggle_crouch():
	is_crouching = !is_crouching
	
	if is_crouching:
		# Scale down the collision shape and mesh
		collision_shape.shape.height = crouch_height
		mesh_instance.scale.y = crouch_height / default_height
		# Adjust the position to avoid floating
		mesh_instance.position.y = -(default_height - crouch_height) / 2
		# Lower the camera/head position
		head.position.y = crouch_height / 2
	else:
		# Reset to default height
		collision_shape.shape.height = default_height
		mesh_instance.scale.y = 1.0
		mesh_instance.position.y = 0
		head.position.y = 1.03903 # Original position from the scene
