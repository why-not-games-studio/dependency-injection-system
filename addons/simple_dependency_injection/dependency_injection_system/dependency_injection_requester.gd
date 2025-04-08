class_name DependencyInjectionRequester
extends Node


func _ready() -> void:
	IDependencyProvider.request_dependency_injection.call_deferred()
	await get_tree().process_frame
	queue_free()
