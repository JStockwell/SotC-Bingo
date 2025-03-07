extends Node

func _on_generate_board_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/2d/bingo.tscn")


func _on_set_times_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/ui/set_times.tscn")
