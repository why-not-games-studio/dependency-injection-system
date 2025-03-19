extends Node


func _inject(pause_manager: PauseManager, game_manager: GameManagerBase, game_manager_two: GameManagerBase, dependency_without_base_class: DependencyWithoutBaseClass) -> void:
	print(str(_inject), ": ", str(pause_manager, " ", game_manager, " ", game_manager_two, " ", dependency_without_base_class))
	print()
	dependency_without_base_class.execute()
