@tool
extends EditorPlugin


const AUTOLOAD_NAME: StringName = "IDependencyProvider"


func _enable_plugin() -> void:
	add_autoload_singleton(AUTOLOAD_NAME, "res://addons/simple_dependency_injection/dependency_injection_system/dependency_provider_interface.gd")

func _disable_plugin() -> void:
	remove_autoload_singleton(AUTOLOAD_NAME)
