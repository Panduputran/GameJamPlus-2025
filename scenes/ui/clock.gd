extends Control

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var narrative_label: Label = $NarrativeText

const TOTAL_DURATION_SECONDS: float = 6.0
const NEXT_SCENE_PATH := "res://scenes/narasi/Narasi1.tscn" # UBAH sesuai path kamu

func _ready() -> void:
	print("Scene Narasi dimulai. Durasi diatur ke %s detik." % TOTAL_DURATION_SECONDS)

	var timer: SceneTreeTimer = get_tree().create_timer(TOTAL_DURATION_SECONDS)
	timer.timeout.connect(_on_timer_timeout)


func _on_timer_timeout() -> void:
	print("Waktu 6 detik selesai. Scene siap untuk transisi.")

	# Opsional: kalau mau fade out dulu
	# animation_player.play("fade_out")

	# Setelah fade out bisa tambah delay dikit kalau perlu
	# await animation_player.animation_finished

	# Langsung ganti scene
	get_tree().change_scene_to_file(NEXT_SCENE_PATH)
