class_name DependencyInjectionRequester
extends Node


func _ready() -> void:
	IDependencyProvider.request_dependency_injection()
	queue_free()
