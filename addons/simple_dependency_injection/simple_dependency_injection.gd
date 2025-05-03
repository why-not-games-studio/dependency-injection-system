@tool
extends EditorPlugin


var _dependency_registrar: DependencyRegistrarBase
var _dependency_provider: DependencyProvider


func _enable_plugin() -> void:
	var scene_root = get_editor_interface().get_edited_scene_root()
	if scene_root:
		_dependency_registrar = DependencyRegistrar.new()
		_dependency_provider = DependencyProvider.new()
		_dependency_provider.set_dependency_registrar(_dependency_registrar)
		
		_dependency_registrar.name = "DependencyRegistrar"
		_dependency_provider.name = "DependencyProvider"
		
		scene_root.add_child(_dependency_registrar)
		scene_root.add_child(_dependency_provider)
		
		_dependency_registrar.owner = scene_root
		_dependency_provider.owner = scene_root

func _disable_plugin() -> void:
	if _dependency_registrar and _dependency_registrar.is_inside_tree() \
		and _dependency_provider and _dependency_provider.is_inside_tree():
			_dependency_registrar.queue_free()
			_dependency_provider.queue_free()
			_dependency_registrar = null
			_dependency_provider = null
