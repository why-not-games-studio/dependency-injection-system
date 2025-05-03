class_name TestReceiver
extends Node


func _inject(
	pause_manager: PauseManager, 
	game_manager: GameManagerBase, 
	game_manager_two: GameManagerBase, 
	dependency_without_base_class: DependencyWithoutBaseClass) -> void:
	print("%s: %s %s %s %s" % 
		[_inject, 
		pause_manager, 
		game_manager, 
		game_manager_two, 
		dependency_without_base_class])
	print()
	if dependency_without_base_class != null:
		dependency_without_base_class.execute()

func _post_inject() -> void:
	print("%s post injected." % name)
