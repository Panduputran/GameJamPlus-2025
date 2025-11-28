extends Area3D
class_name InteractiveObject

# Pesan yang akan dicetak atau ditampilkan di UI saat interaksi siap.
@export var message: String = "Tekan F untuk berinteraksi!"

# Jalur scene (Scene Path) yang akan dimuat saat objek ini diinteraksikan.
# Contoh: "res://scenes/ui/level_2.tscn"
@export_file("*.tscn") var target_scene_path: String = ""

# Enumerasi (opsional) untuk jenis aksi, memudahkan pengaturan di editor
enum InteractionType { CHANGE_SCENE, GIVE_ITEM, TRIGGER_ANIMATION }
@export var interaction_type: InteractionType = InteractionType.CHANGE_SCENE

func _ready():
	# Menghubungkan sinyal bawaan Godot untuk deteksi tubuh (body) yang masuk dan keluar
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body: Node3D):
	# Memastikan body yang masuk adalah Player (sesuai nama node "Player")
	if body is CharacterBody3D and body.name == "Player":
		print("Informasi: ", message)
		# Mendaftarkan diri sebagai objek yang siap diinteraksikan secara global
		GlobalSignals.set_interactable_object(self)

func _on_body_exited(body: Node3D):
	if body is CharacterBody3D and body.name == "Player":
		print("Keluar dari area interaksi.")
		# Hanya membatalkan pendaftaran jika objek ini yang terdaftar
		if GlobalSignals.get_interactable_object() == self:
			GlobalSignals.set_interactable_object(null)

func interact():
	print("Interaksi berhasil! Aksi: ", interaction_type, " untuk objek: ", name)
	
	# Logika Aksi Interaksi (berdasarkan interaction_type)
	match interaction_type:
		InteractionType.CHANGE_SCENE:
			if !target_scene_path.is_empty():
				# Memanggil fungsi global di GlobalSignals untuk mengganti scene
				GlobalSignals.change_scene_to(target_scene_path)
			else:
				print("ERROR: target_scene_path kosong untuk mode CHANGE_SCENE!")
				
		InteractionType.GIVE_ITEM:
			# Di sini Anda bisa menambahkan logika untuk memberikan item
			print("Item diberikan! Logika inventaris perlu ditambahkan di sini.")
			pass # Tambahkan kode untuk memberi item

		InteractionType.TRIGGER_ANIMATION:
			# Di sini Anda bisa menambahkan logika untuk memicu animasi
			print("Animasi dipicu! Logika animasi perlu ditambahkan di sini.")
			pass # Tambahkan kode untuk memicu animasi
	
	# Objek telah digunakan (opsional: jika Anda ingin objek menghilang setelah interaksi)
	# Jika objek ini tidak boleh hilang, hapus dua baris di bawah ini.
	queue_free()
	GlobalSignals.set_interactable_object(null)
