extends Control
@onready var credits: Control = $"."
@onready var click: AudioStreamPlayer = $"../AudioStreamPlayer"
@onready var main_menu: Control = $".."
@onready var p1: TextureRect = $"../TextureRect2"
@onready var p: VBoxContainer = $"../MenuContainer"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_back_pressed() -> void:
	click.play()
	credits.visible = false
	p1.visible = true
	p.visible = true
