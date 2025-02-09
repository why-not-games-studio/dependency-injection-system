class_name PauseManagerBase
extends Node


signal paused
signal played


func pause() -> void:
	get_tree().paused = true
	paused.emit()


func play() -> void:
	get_tree().paused = false
	played.emit()
