extends Control
@onready var mechanics: Control = $"."
@onready var setting_container: Control = $"../SettingContainer"
@onready var click: AudioStreamPlayer = $AudioStreamPlayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_back_pressed() -> void:
	click.play()
	mechanics.visible = false
	setting_container.visible = true
