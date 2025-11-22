# GlobalSignals.gd
# Make sure this is set up as a singleton/AutoLoad in Project Settings.

extends Node

var _current_interactable_object: InteractiveObject = null

func set_interactable_object(obj: InteractiveObject):
	_current_interactable_object = obj
	print("GlobalSignals: Set interactable object to ", str(obj.name) if obj != null else "null")

func get_interactable_object() -> InteractiveObject:
	print("GlobalSignals: Getting interactable object: ", _current_interactable_object)
	return _current_interactable_object

func change_scene_and_interact():
	# This new function will handle the scene change.
	print("Interaction detected! Changing scene...")
	get_tree().change_scene_to_file("res://scenes/ui/loadingintro.tscn")
