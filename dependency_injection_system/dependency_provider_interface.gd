## Serves as an Abstraction between any [DependencyProvider] and its dependents 
## and MUST be a Global Autoload if Dependency Injection functionality is desired.
## IDependencyProvider
extends Node


signal dependency_registration_requested(dependency: Node)
signal dependency_deregistration_requested(dependency_name: StringName)

signal dependency_injection_requested


func register_dependency(dependency: Node) -> void:
	dependency_registration_requested.emit(dependency)

func deregister_dependency(dependency_name: StringName) -> void:
	dependency_deregistration_requested.emit(dependency_name)


func request_dependency_injection() -> void:
	dependency_injection_requested.emit()
