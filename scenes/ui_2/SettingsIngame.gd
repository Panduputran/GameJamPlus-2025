extends Control
@onready var margin_container = $"../MarginContainer"
@onready var v_box_container = $"../MarginContainer/VBoxContainer"
@onready var settings_2 = $"../Settings2"
@onready var credit = $"../Credit"
@onready var settings = $"."





func _on_control_pressed():
	credit.visible = true
	


func _on_back_pressed():
	settings.visible = false
	


func _on_settings_pressed():
	settings_2.visible = true
	settings.visible = false


func _on_credit_pressed():
	credit.visible = true
	settings.visible = false
