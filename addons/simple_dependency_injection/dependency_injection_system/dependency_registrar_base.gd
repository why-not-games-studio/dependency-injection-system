## Serves as the base class for any DependencyRegistrar implementation
## to provide an interface that other modules can interact with.
class_name DependencyRegistrarBase
extends Node


func get_dependency(_dependency_name: StringName) -> Node:
	return null


func register_dependency(_dependency: Node) -> void:
	pass

func deregister_dependency(_dependency_name: StringName) -> void:
	pass
