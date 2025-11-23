extends CharacterBody3D

# === Player Settings ===
@export var walk_speed := 3.0
@export var sprint_speed := 8.0
@export var jump_velocity := 4.5
@export var mouse_sensitivity := 0.002

@export var enable_sprint := true
@export var enable_jump := true

# === UI ===
@onready var ui_player: Control = $"UI Player"
@onready var pause: Control = $Pause
@onready var camera: Camera3D = $Camera3D

var current_speed := 0.0
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _input(event):
	# === Mouse Look ===
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		rotate_y(-event.relative.x * mouse_sensitivity)
		camera.rotate_x(-event.relative.y * mouse_sensitivity)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-90), deg_to_rad(90))
		return

	# === ESC Pause / Resume ===
	if Input.is_action_just_pressed("ui_cancel"):
		ui_player.visible = false
		pause.visible = true

		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

	# === Interact ===
	if Input.is_action_just_pressed("interact"):
		if GlobalSignals.get_interactable_object() != null:
			var obj = GlobalSignals.get_interactable_object()
			obj.interact()


func _physics_process(delta):
	# === Gravity ===
	if not is_on_floor():
		velocity.y -= gravity * delta

	# === Jump ===
	if enable_jump:
		if Input.is_action_just_pressed("") and is_on_floor():
			velocity.y = jump_velocity

	# === Movement Speed Logic ===
	current_speed = walk_speed

	if enable_sprint:
		if Input.is_action_pressed(""):
			current_speed = sprint_speed

	# === Movement Vector ===
	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	if direction:
		velocity.x = direction.x * current_speed
		velocity.z = direction.z * current_speed
	else:
		velocity.x = move_toward(velocity.x, 0, current_speed)
		velocity.z = move_toward(velocity.z, 0, current_speed)

	move_and_slide()
