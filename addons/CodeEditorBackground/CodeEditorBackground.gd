@tool
extends EditorPlugin

var cse
var se

func _enter_tree():
	get_editor_interface().get_script_editor().connect("editor_script_changed", Callable(self, "changed"))
	get_editor_interface().get_script_editor().connect("resized", Callable(self, "ResizeBackground"))


func changed(script: Script):
	cse = get_editor_interface().get_script_editor().get_current_editor()
	se = cse.get_child(0).get_child(0).get_child(0)
	var bg = TextureRect.new()
	bg.texture = load("res://addons/CodeEditorBackground/Background/Background.png")
	bg.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_COVERED
	bg.self_modulate = Color("ffffff1e")
	bg.size = cse.get_child(0).get_child(0).get_child(0).size


	if se.get_child_count() == 1:
		se.get_child(0).queue_free()
	se.add_child(bg)
	se.move_child(bg, 0)

func ResizeBackground():
	if se.get_child_count() == 1:
		se.get_child(0).size = se.size
