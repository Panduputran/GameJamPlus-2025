# interactive_object.gd
extends Area3D
class_name InteractiveObject

@export var message = "You interacted with an object!"

func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body: Node3D):
	if body is CharacterBody3D and body.name == "Player":
		print("Press F to interact with: ", name)
		GlobalSignals.set_interactable_object(self)

func _on_body_exited(body: Node3D):
	if body is CharacterBody3D and body.name == "Player":
		print("Exited interaction area.")
		if GlobalSignals.get_interactable_object() == self:
			GlobalSignals.set_interactable_object(null)

func interact():
	print(message)
	# This is the line that needs to change.
	# Instead of just freeing the object, we also tell the GlobalSignals
	# to change the scene.
	GlobalSignals.change_scene_and_interact()
	
	# The object is now "taken," so we free it.
	queue_free()
	GlobalSignals.set_interactable_object(null)
