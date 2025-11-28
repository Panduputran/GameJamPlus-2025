# GlobalSignals.gd
# Pastikan ini disetel sebagai singleton/AutoLoad di Project Settings.

extends Node

var _current_interactable_object: InteractiveObject = null

# Sinyal kustom yang dapat dipancarkan ketika sesuatu terjadi secara global
# Contoh: signal object_interacted(object_name)

func set_interactable_object(obj: InteractiveObject):
	_current_interactable_object = obj
	print("GlobalSignals: Set objek interaksi ke ", str(obj.name) if obj != null else "null")

func get_interactable_object() -> InteractiveObject:
	print("GlobalSignals: Mengambil objek interaksi: ", _current_interactable_object)
	return _current_interactable_object

# Hapus fungsi 'change_scene_and_interact()' dari sini.
# Sekarang setiap InteractiveObject akan memanggil get_tree().change_scene_to_file() sendiri
# dengan file scene yang berbeda.

func change_scene_to(scene_path: String):
	# Fungsi pembantu global baru untuk mengganti scene.
	print("Interaksi terdeteksi! Mengganti scene ke: ", scene_path)
	get_tree().change_scene_to_file(scene_path)
