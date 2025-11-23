extends Control
@onready var settings: Control = $Settings
@onready var credits: Control = $credits
@onready var quit: Button = $MenuContainer/Button4
@onready var click: AudioStreamPlayer = $AudioStreamPlayer
@onready var main_menu: Control = $"."
@onready var p1: VBoxContainer = $MenuContainer
@onready var p: TextureRect = $TextureRect2



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	click.play() # Cukup panggil .play()
	await click.finished
	get_tree().change_scene_to_file("res://scenes/ui/loading.tscn")

func _on_button_2_pressed() -> void:
	click.play() # Cukup panggil .play()
	settings.visible = true
	p1.visible = false
	p.visible = false

func _on_button_3_pressed() -> void:
	click.play() # Cukup panggil .play()
	credits.visible = true
	p1.visible = false
	p.visible = false


func _on_button_4_pressed() -> void:
	click.play() # Cukup panggil .play()
	await click.finished
	get_tree().quit()
	
