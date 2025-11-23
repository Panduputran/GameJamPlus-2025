extends Control

@onready var count_label: Label = $count

var progres: Array = []
var scene_path: String = "res://scenes/narasi/narasi1.tscn"

# Minimal durasi loading screen
const MINIMUM_LOAD_TIME: float = 7.0


func _ready() -> void:
	# Mulai proses loading & timer
	_start_loading_sequence()


func _process(delta: float) -> void:
	# Update progress persentase
	var status := ResourceLoader.load_threaded_get_status(scene_path, progres)
	if not progres.is_empty():
		count_label.text = str(floor(progres[0] * 100.0)) + "%"


# ----------------------------
# Loading + minimal waktu
# ----------------------------
func _start_loading_sequence() -> void:
	ResourceLoader.load_threaded_request(scene_path)

	var start_time := Time.get_ticks_msec()

	# Tunggu sampai thread load selesai
	await _wait_for_thread_load()

	# Hitung sisa waktu agar total 5 detik
	var elapsed := float(Time.get_ticks_msec() - start_time) / 1000.0
	var remaining := MINIMUM_LOAD_TIME - elapsed
	if remaining > 0:
		await get_tree().create_timer(remaining).timeout

	# Setelah semua syarat terpenuhi → pindah scene
	_change_scene()


func _wait_for_thread_load() -> void:
	while ResourceLoader.load_threaded_get_status(scene_path) != ResourceLoader.THREAD_LOAD_LOADED:
		await get_tree().process_frame


func _change_scene() -> void:
	var packed := ResourceLoader.load_threaded_get(scene_path)
	if packed == null:
		push_error("Failed to load scene: " + scene_path)
		return

	get_tree().change_scene_to_packed(packed)
