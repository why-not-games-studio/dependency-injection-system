@tool
extends EditorPlugin


func _enable_plugin() -> void:
	var scene_root = get_editor_interface().get_edited_scene_root()
	if scene_root:
		var dependency_registrar = DependencyRegistrar.new()
		var dependency_provider = DependencyProvider.new()
		dependency_provider.set_dependency_registrar(dependency_registrar)
		
		dependency_registrar.name = "DependencyRegistrar"
		dependency_provider.name = "DependencyProvider"
		
		scene_root.add_child(dependency_registrar)
		scene_root.add_child(dependency_provider)
		
		dependency_registrar.owner = scene_root
		dependency_provider.owner = scene_root

func _disable_plugin() -> void:
	var scene_root = get_editor_interface().get_edited_scene_root()
	if scene_root:
		var registrar_node: Node = scene_root.find_child("DependencyRegistrar")
		if registrar_node and registrar_node is DependencyRegistrar:
			registrar_node.queue_free()

		var provider_node = scene_root.find_child("DependencyProvider")
		if provider_node and provider_node is DependencyProvider:
			provider_node.queue_free()
