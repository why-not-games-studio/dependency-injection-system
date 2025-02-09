extends Node


func _inject(pause_manager: PauseManagerBase, game_manager: GameManagerBase) -> void:
	ILogger.log_debug(str(name, " ", pause_manager, " ", game_manager), str(_inject))
