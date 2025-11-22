extends Control

@onready var animation_player = $AnimationPlayer

var progres = []
var sceneN
var sceneLS = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	sceneN = "res://scenes/ui/main_menu.tscn"
	ResourceLoader.load_threaded_request(sceneN)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	sceneLS = ResourceLoader.load_threaded_get_status(sceneN,progres)
	$count.text = str(floor(progres[0]+100)) + "%"
	await get_tree().create_timer(0.7).timeout
	if sceneLS == ResourceLoader.THREAD_LOAD_LOADED:
		var new = ResourceLoader.load_threaded_get(sceneN)
		get_tree().change_scene_to_packed(new)
		animation_player.play("fade_in")
