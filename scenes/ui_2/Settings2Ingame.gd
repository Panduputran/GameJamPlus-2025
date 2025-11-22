extends Control
@onready var options = $"."
@onready var margin_container = $"../MarginContainer"
@onready var graphic = $Text/Graphic/HSlider2
@onready var volume = $Text/Volume/HSlider
@onready var brightness = $Text/Volume2/HSlider3
@onready var settings_2 = $"."
@onready var settings = $"../Settings"
@onready var sensitivity = $Text/Sensitivity/HSlider3
@onready var control_settings = $"../ControlSettings"


var default_value = 50 # Ganti dengan nilai default yang Anda inginkan

func _ready():
	graphic.value = default_value
	volume.value = default_value
	brightness.value = default_value
	sensitivity.value = default_value

func _on_back_pressed():
	settings_2.visible = false
	settings.visible = true
	


func _on_reset_pressed():
	graphic.value = default_value
	volume.value = default_value
	brightness.value = default_value
	sensitivity.value = default_value


func _on_control_pressed():
	control_settings.visible = true 
	settings_2.visible = false

func _on_graphic_value_changed(value):
	pass # Replace with function body.


func _on_volume_value_changed(value):
	pass # Replace with function body.


func _on_brightness_value_changed(value):
	pass # Replace with function body.


func _on_sensitivity_value_changed(value):
	pass # Replace with function body.
