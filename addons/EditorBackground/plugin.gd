@tool
extends EditorPlugin

var open_scripts:Array
var wait_time_between_script_checks := 3.0
const script_child_size_no_background := 1

var base
var tabContainer
var vbox630


func _enter_tree() -> void:
	print("SAVE ANY SCENE TO INITIALIZE YOUR BACKGROUND.")																								#										#
#	print(get_editor_interface().get_base_control().get_child(1).get_child(1).get_child(1).get_child(1).get_child(0).get_child(0).get_child(0).get_child(0).get_child(1).get_child(0).get_child(2).get_child(0).get_child(1).get_child(1).get_child(0))
	var timer = Timer.new()
	timer.wait_time = wait_time_between_script_checks
	timer.set_autostart(true)
	self.add_child(timer)
	timer.timeout.connect(Callable(self, 'on_timeout'))
	
	

#
#
#

	
	
func _exit_tree() -> void:
	queue_free()

#
func on_timeout() -> void:
	var script_count = get_editor_interface().get_script_editor().get_open_scripts()
	var ScriptTextEditor2
	var ScriptText
	if script_count:
		base = get_editor_interface()
		if is_instance_valid(base.get_base_control()):
			vbox630 = base.get_base_control().get_child(1).get_child(1).get_child(1).get_child(1).get_child(0).get_child(0).get_child(0).get_child(0)
			ScriptTextEditor2 = vbox630.get_child(1).get_child(0).get_child(2)
			ScriptText = ScriptTextEditor2.get_child(0).get_child(1).get_child(1).get_child(0).get_child(1).get_child(0).get_child(0)
			tabContainer = ScriptTextEditor2.get_child(0).get_child(1).get_child(1).get_child(0)
		#	check_scripts()
			open_scripts.clear()
		

#
		if is_instance_valid(tabContainer) and tabContainer.get_children():
			var scriptedit
			for s in tabContainer.get_children():
				pass
	#			printerr(s)
				
				open_scripts.append(s)
	#			print("")
	#			printerr(open_scripts)
	#			for c in s.get_children():
	#				print(c.get_class())
	#			if s.name in ["17092", "17281", "ScriptTextEditor"]:
	#			print(ScriptTextEditor2.get_child(0).get_child(1).get_child(1).get_child(0).get_child(1).get_child(0).get_child(0).get_child(0))
	#			for script in open_scripts:
	#				print(script)
	#				pass

	#			scriptedit = tabContainer.get_node(str(s.name))
	#			print(scriptedit)

	#			open_scripts.append(scriptedit)
	#			print(ScriptText.get_child(0).get_children())
	#		open_scripts.remove_at(open_scripts.size()-1)
	#		open_scripts.remove_at(0)
	#		print(open_scripts)

			for script in open_scripts:
	#			print(script.get_child(0).get_child(0).get_child(0).get_child(0).get_class())
	#			print(script.get_child(0).get_child(0).get_child(0).get_children().size())
				if is_instance_valid(script.get_child(0).get_child(0)):
					if script.get_child(0).get_child(0).get_child(0).get_children().is_empty():
						if script.get_child(0).get_child(0).get_child(0).get_children().is_empty():
							var texture_rect := TextureRect.new()
							texture_rect.texture = load("res://addons/EditorBackground/Background.png")
							texture_rect.ignore_texture_size = true
							texture_rect.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
							texture_rect.modulate = Color('ffffff14')
							texture_rect.name = 'BackgroundImage'
							self.tree_exiting.connect(Callable(texture_rect, "queue_free"))
							script.get_child(0).get_child(0).get_child(0).add_child(texture_rect)
							script.get_child(0).get_child(0).get_child(0).move_child(texture_rect, 0)
							if !script.is_connected("resized", Callable(self, "match_rect")):
			#					print(script)
								script.resized.connect(match_rect.bind(texture_rect, script))
							match_rect(texture_rect, script)
				#					add_image(scriptedit)
	#					else:
	#						continue
#
func match_rect(of: Control, to: Control) -> void:
#	printt(of.size, to.size)
	of.custom_minimum_size = to.custom_minimum_size
	of.size = to.size
	of.position = to.position
	
#func add_image(code) -> void:
#	var texture_rect := TextureRect.new()
#	texture_rect.texture = load("res://addons/EditorImage/Background.png")
#	texture_rect.expand = true
#	texture_rect.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
#	texture_rect.modulate = Color('14ffffff')
#	texture_rect.name = 'BackgroundImage'
#	self.tree_exiting.connect(Callable(texture_rect, "queue_free"))
#
#	code.add_child(texture_rect)
#	code.move_child(texture_rect, 0)
#	code.connect("resized", self, "match_rect", [ texture_rect, code ])
#	match_rect(texture_rect, code)
#
#
#func check_scripts() -> void:
#	var script_count = get_editor_interface().get_script_editor().get_open_scripts()
#	if script_count:
#		base = get_editor_interface()
#
#		if is_instance_valid(base) and is_instance_valid(base.get_child(0)):
#
#			if base.get_base_control().get_child(0).get_child_count() >= 2:
#
#				if is_instance_valid(base.get_child(0).get_child(1)) and is_instance_valid(base.get_child(0).get_child(1).get_child(1)):
#
#					vbox630 = base.get_base_control().get_child(1).get_child(1).get_child(1).get_child(1).get_child(0).get_child(0).get_child(0).get_child(0)
#					print(vbox630.name)
#					var ScriptTextEditor2 = vbox630.get_child(1).get_child(0).get_child(2)
#					var ScriptText = ScriptTextEditor2.get_child(0).get_child(1).get_child(1).get_child(0).get_child(1).get_child(0).get_child(0)
#					tabContainer = vbox630.get_child(1).get_child(0).get_child(2).get_child(0).get_child(1).get_child(1).get_child(0)
#	else:
#		pass




