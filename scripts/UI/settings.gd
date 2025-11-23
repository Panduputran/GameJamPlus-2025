extends Control
@onready var settings: Control = $"."
var default_volume: float = 0.5
var default_brightness: float = 1.0
var default_sensitivity: float = 0.5
@onready var click: AudioStreamPlayer = $"../AudioStreamPlayer"
@onready var music: AudioStreamPlayer = $"../MusicMain"
@onready var music_slider: HSlider = $SettingContainer/Volume
@onready var p1: VBoxContainer = $"../MenuContainer"
@onready var p: TextureRect = $"../TextureRect2"
@onready var mechanics: Control = $SettingContainer/Mechanics
@onready var settingcontainer: TextureRect = $"SettingContainer/SettingsPanel"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_back_pressed() -> void:
	click.play()
	settings.visible = false
	p1.visible = true
	p.visible = true



func _on_volume_changed() -> void:
	pass


func _on_reset_pressed() -> void:
	pass # Replace with function body.


func _on_option_button_item_selected(index: int) -> void:
	pass # Replace with function body.


func _on_brighness_changed() -> void:
	pass # Replace with function body.


func _on_sensitivity_changed() -> void:
	pass # Replace with function body.


func _on_mute_toggled(toggled_on: bool) -> void:
	pass # Replace with function body.


func _on_control_pressed() -> void:
	click.play()
	mechanics.visible = true
	settingcontainer.visible = false
