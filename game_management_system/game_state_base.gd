class_name GameStateBase
extends Node


func enter_state(_prev_game_state: GameStateBase) -> void:
	process_mode = ProcessMode.PROCESS_MODE_INHERIT


func exit_state() -> void:
	process_mode = ProcessMode.PROCESS_MODE_DISABLED
