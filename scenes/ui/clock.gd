extends Control

@onready var animation_player = $AnimationPlayer
@onready var count_label = $count # Asumsi label progress Anda bernama 'count'

var progres = []
var sceneN: String
var sceneLS = 0

# Waktu minimum loading yang diinginkan (dalam detik)
const MINIMUM_LOAD_TIME = 5.0

# Called when the node enters the scene tree for the first time.
func _ready():
	sceneN = "res://scenes/narasi/narasi1.tscn"
	ResourceLoader.load_threaded_request(sceneN)
	
	# Memanggil fungsi yang menjalankan proses loading
	load_scene_with_timer()

func _process(delta):
	# Update progress
	sceneLS = ResourceLoader.load_threaded_get_status(sceneN, progres)
	if not progres.is_empty():
		# Pastikan kita menghitung progress dengan benar, karena progres[0] adalah 0.0 - 1.0
		count_label.text = str(floor(progres[0] * 100)) + "%"

# Fungsi utama yang menangani loading dan timer
func load_scene_with_timer():
	
	# 1. Menunggu sampai sumber daya selesai dimuat (ResourceLoader.THREAD_LOAD_LOADED)
	while sceneLS != ResourceLoader.THREAD_LOAD_LOADED:
		# Menunggu sebentar agar tidak memakan banyak CPU
		await get_tree().process_frame
		# Perbarui status sceneLS di _process atau di sini jika perlu.
		# Catatan: _process akan terus berjalan di background, memperbarui count_label.
		
	# Setelah loading selesai, kita menunggu MINIMUM_LOAD_TIME dari awal
	# Karena kita sudah menunggu selesai loading, kita perlu menunggu waktu sisanya.
	
	# 2. Membuat timer 5 detik (dimulai sejak _ready)
	# Cara paling sederhana: tunggu 5 detik total
	# Karena kita tidak tahu berapa lama loading aslinya, kita asumsikan ini berjalan cepat.
	
	# Untuk memastikan minimal 5 detik DARI AWAL _ready:
	# Kita tidak bisa mengukur waktu secara akurat di sini tanpa mencatat waktu mulai.
	
	# SOLUSI YANG LEBIH BAIK:
	# Kita buat timer 5 detik, dan pastikan loading selesai sebelum timer berakhir.
	
	var minimum_timer = get_tree().create_timer(MINIMUM_LOAD_TIME)
	
	# Menunggu KEDUA kondisi terpenuhi:
	# a. ResourceLoader.THREAD_LOAD_LOADED tercapai (sudah dilakukan di loop while di atas)
	# b. Timer 5 detik berakhir
	
	# Jika loading selesai (sceneLS == THREAD_LOAD_LOADED), kita tunggu sisa waktu 5 detik.
	
	# Jika Anda ingin 5 detik DARI SEKARANG (setelah loading selesai):
	# await get_tree().create_timer(5.0).timeout
	
	# Jika Anda ingin total 5 detik:
	
	# Cek Waktu Mulai
	var start_time = Time.get_ticks_msec()
	
	# Loop untuk loading (seperti sebelumnya, biarkan _process yang mengurus tampilan)
	while ResourceLoader.load_threaded_get_status(sceneN) != ResourceLoader.THREAD_LOAD_LOADED:
		await get_tree().process_frame
		
	# Setelah loading selesai, hitung waktu yang sudah berlalu
	var elapsed_time = (Time.get_ticks_msec() - start_time) / 1000.0
	var remaining_time = MINIMUM_LOAD_TIME - elapsed_time
	
	# Jika waktu yang tersisa positif, tunggu sisa waktu tersebut
	if remaining_time > 0:
		await get_tree().create_timer(remaining_time).timeout
		
	# 3. Transisi Scene
	perform_transition()


func perform_transition():
	# Pastikan statusnya sudah LOADED
	if ResourceLoader.load_threaded_get_status(sceneN) == ResourceLoader.THREAD_LOAD_LOADED:
		var new_scene = ResourceLoader.load_threaded_get(sceneN)
		
		# Mainkan animasi fade_in
		animation_player.play("fade_in")
		
		# Menunggu sampai animasi fade_in selesai sebelum transisi.
		# Anda mungkin ingin fade_out layar loading, bukan fade_in.
		await animation_player.animation_finished
		
		# Lakukan transisi scene
		get_tree().change_scene_to_packed(new_scene)
