extends Control


func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	 # Aguarda o próximo frame para garantir que a UI estabilizou
	await get_tree().process_frame 
	$Yes.grab_focus()

func _input(event):
	if event is InputEventMouseMotion:
		var focused_node = get_viewport().gui_get_focus_owner()
		if focused_node:
			focused_node.release_focus()
	elif event.is_action_pressed("ui_up") or event.is_action_pressed("ui_down") or \
		event.is_action_pressed("ui_left") or event.is_action_pressed("ui_right"):

		if get_viewport().gui_get_focus_owner() == null:
			$Yes.grab_focus()
			get_viewport().set_input_as_handled()



func _on_yes_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/tutorial.tscn")


func _on_no_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/central_phase_1.tscn")
