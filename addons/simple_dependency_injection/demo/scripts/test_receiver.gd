extends Node


func _inject(pause_manager: PauseManagerBase, game_manager: GameManager, dependency: DependencyWithoutBaseClass) -> void:
	print(str(_inject), ": ", str(pause_manager, " ", game_manager, " ", dependency))
	print()
	dependency.execute()
