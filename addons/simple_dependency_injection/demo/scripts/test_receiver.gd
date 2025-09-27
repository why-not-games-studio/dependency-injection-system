class_name TestReceiver
extends Node

func _enter_tree() -> void:
	print("\n%s entered tree.\n" % name)

func _inject(
	pause_manager: PauseManager, 
	game_manager: GameManagerBase, 
	game_manager_two: GameManagerBase, 
	dependency_without_base_class: DependencyWithoutBaseClass,
	dependency_without_class_name) -> void:
	print("%s: %s %s %s %s %s" % 
		[_inject, 
		pause_manager, 
		game_manager, 
		game_manager_two, 
		dependency_without_base_class,
		dependency_without_class_name])
	print()
	if dependency_without_base_class != null:
		dependency_without_base_class.execute()
	if dependency_without_class_name != null:
		dependency_without_class_name.execute()

func _ready() -> void:
	print("\n%s is ready." % name)
