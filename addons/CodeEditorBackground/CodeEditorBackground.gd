@tool
extends EditorPlugin

var cse
var se
var defaultBackground := "res://addons/CodeEditorBackground/Background/Background.png"
var userBackground : String

func _enter_tree():
	get_editor_interface().get_script_editor().connect("editor_script_changed", Callable(self, "changed"))
	get_editor_interface().get_script_editor().connect("resized", Callable(self, "ResizeBackground"))
	add_tool_menu_item("Change Background", Callable(self, "ShowWindow"))


func _exit_tree():
	remove_tool_menu_item("Change Background")


func changed(script: Script):
	cse = get_editor_interface().get_script_editor().get_current_editor()
	se = cse.get_child(0).get_child(0).get_child(0)
	var bg = TextureRect.new()
	
	if userBackground:
		var img = Image.new()
		img.load(userBackground)
		var tex = ImageTexture.new()
		tex.set_image(img)
		bg.texture = tex

	else:
		bg.texture = load(defaultBackground)
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


func ShowWindow():
	var w = load("res://addons/CodeEditorBackground/file_dialog.tscn").instantiate()
	w.initial_position = Window.WINDOW_INITIAL_POSITION_CENTER_MAIN_WINDOW_SCREEN
	w.size = Vector2(500, 300)
	add_child(w)
	w.connect("file_selected", Callable(self, "LoadImage"))


func LoadImage(path):
	userBackground = path
	changed(null)
