extends Control
@onready var pause = $"."
@onready var menu = $"."
@onready var margin_container = $MarginContainer
@onready var quit = $Quit
@onready var v_box_container = $MarginContainer/VBoxContainer
@onready var label = $Label
@onready var control_settings = $ControlSettings
@onready var settings = $CanvasLayer/Settings
@onready var credit = $CanvasLayer2/Credit

func _ready() -> void:
	hide()
	process_mode = Node.PROCESS_MODE_ALWAYS
	get_tree().paused = false
	settings.visible = false
	credit.visible = false
	process_mode = Node.PROCESS_MODE_ALWAYS
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	process_mode = Node.PROCESS_MODE_ALWAYS

func _on_play_pressed():
	get_tree().change_scene_to_file("res://User Interface/LoadingScreen.tscn")
	
func _on_quit_pressed():
	quit.visible = true
	
func _on_options_pressed():
	settings.visible = true
	v_box_container.visible = false


func _on_settings_pressed():
	settings.visible = true


func _on_credit_pressed():
	credit.visible = true


func _on_resume_pressed(s) -> void:
	var tree = get_tree()
	tree.paused = false
	close()


	

func _unhandled_input(event: InputEvent) -> void:
	if visible and event.is_action_pressed("ui_cancel"): 
		resume_game()
		get_tree().root.set_input_as_handled()

func open() -> void:
	show()

func close() -> void:
	hide()

func resume_game() -> void:
	var tree = get_tree()
	tree.paused = false
	close()



func _on_menu_pressed():
	get_tree().change_scene_to_file("res://User Interface/LoadingScreen2.tscn")
