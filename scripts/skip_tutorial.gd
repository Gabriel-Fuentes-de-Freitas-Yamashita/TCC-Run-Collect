extends Control

func _on_yes_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/tutorial.tscn")


func _on_no_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/central_phase_1.tscn")
