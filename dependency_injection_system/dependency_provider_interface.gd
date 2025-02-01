## Serves as an abstraction between any DependencyProvider and its dependents 
## and must be autoloaded as global if Dependency Injection functionality is desired.
class_name DependencyProviderInterface
extends Node


signal dependency_registration_requested(dependency: Node)
signal dependency_deregistration_requested(dependency_name: StringName)

signal dependency_provision_requested(dependency_names: Array[StringName])
signal dependency_provision_completed(dependencies: Dictionary, result: Error)


func register_dependency(dependency: Node) -> void:
	dependency_registration_requested.emit(dependency)

func deregister_dependency(dependency_name: StringName) -> void:
	dependency_deregistration_requested.emit(dependency_name)


func request_dependency_provision(dependency_names: Array[StringName]) -> void:
	dependency_provision_requested.emit(dependency_names)

func succeed_dependency_provision(dependencies: Dictionary) -> void:
	dependency_provision_completed.emit(dependencies, OK)

func fail_dependency_provision(error: Error) -> void:
	dependency_provision_completed.emit({}, error)
