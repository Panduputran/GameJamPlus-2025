# pause.gd
extends Control

@onready var pause_screen: Control = $"."
@onready var settings_screen: Control = $Settings
@onready var click: AudioStreamPlayer = $AudioStreamPlayer
@onready var ui_player: Control = $"../UI Player"

# Fungsi untuk melanjutkan game
func resume_game():
	# Mematikan mode pause di seluruh scene tree
	get_tree().paused = false
	
	# Menyembunyikan layar pause
	pause_screen.visible = false
	
	# Mengembalikan mode kursor ke terkunci
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


# Tombol "Resume"
func _on_resume_button_pressed() -> void:
	# Cukup panggil fungsi ini, semua logika ada di dalamnya
	resume_game()


# Tombol "Settings"
func _on_settings_button_pressed() -> void:
	settings_screen.visible = true
	pause_screen.visible = false


# Tombol "Main Menu"
func _on_main_menu_button_pressed() -> void:
	# Sangat penting untuk me-resume game sebelum pindah scene
	resume_game()
	get_tree().change_scene_to_file("res://scenes/ui/main_menu.tscn")
	
	
# Tombol "Quit"
func _on_quit_button_pressed() -> void:
	get_tree().quit()


func _on_button_pressed() -> void:
	# Mematikan mode pause di seluruh scene tree
	click.play()
	get_tree().paused = false
	
	# Menyembunyikan layar pause
	pause_screen.visible = false
	ui_player.visible = true
	
	# Mengembalikan mode kursor ke terkunci
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _on_button_2_pressed() -> void:
	click.play()
	settings_screen.visible = true


func _on_button_3_pressed() -> void:
		get_tree().change_scene_to_file("res://scenes/ui/loadingintro.tscn")
