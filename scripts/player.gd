extends CharacterBody3D

@export var walk_speed = 5.0 # Kecepatan berjalan
@export var sprint_speed = 8.0 # Kecepatan berlari
@export var jump_velocity = 4.5 # Kekuatan lompat
@export var mouse_sensitivity = 0.002 # Sensitivitas mouse
@onready var ui_player: Control = $"UI Player"

@onready var pause: Control = $Pause

var current_speed = walk_speed
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
@onready var camera: Camera3D = $Camera3D



func _ready():
	# Mengunci kursor mouse ke tengah layar dan menyembunyikannya
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _input(event):
	# === Bagian 1: Rotasi Kamera dengan Mouse ===
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		rotate_y(-event.relative.x * mouse_sensitivity) # Rotasi Y (yaw) untuk kiri/kanan
		camera.rotate_x(-event.relative.y * mouse_sensitivity) # Rotasi X (pitch) untuk atas/bawah
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-90), deg_to_rad(90))
		return # Keluar dari fungsi _input jika event adalah gerakan mouse

	# === Bagian 2: Melepaskan kursor mouse dengan tombol ESC ===
	# Gunakan singleton Input untuk memeriksa aksi
	if Input.is_action_just_pressed("ui_cancel"): # <--- PERBAIKAN DI SINI
		ui_player.visible = false
		pause.visible = true
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		

	# === Bagian 3: Logika Interaksi ===
	# Gunakan singleton Input untuk memeriksa aksi
	if Input.is_action_just_pressed("interact"): # <--- PERBAIKAN DI SINI
		print("Interact button 'F' pressed!")
		if GlobalSignals.get_interactable_object() != null:
			var obj_to_interact = GlobalSignals.get_interactable_object()
			print("Trying to interact with: ", obj_to_interact.name)
			obj_to_interact.interact()
		else:
			print("No interactable object in range.")

func _physics_process(delta):
	# Gravitasi
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Lompat
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_velocity

	# Kecepatan lari (sprint)
	current_speed = walk_speed
	if Input.is_action_pressed("sprint"):
		current_speed = sprint_speed

	# Arah input dan pergerakan
	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	if direction:
		velocity.x = direction.x * current_speed
		velocity.z = direction.z * current_speed
	else:
		velocity.x = move_toward(velocity.x, 0, current_speed)
		velocity.z = move_toward(velocity.z, 0, current_speed)

	move_and_slide()
