## For use in enclosed scenes to inject dependencies, which are provided by a dependency provider,
## into its siblings that request it via Method Injection.
class_name DependencyInjector
extends Node


const INJECT_METHOD_NAME: StringName = "_inject"

@export_category("Members")
@export var _dependency_names: Array[StringName]


func _enter_tree() -> void:
	_initialize_dependency_names()
	IDependencyProvider.dependency_provision_completed.connect(_on_dependency_provision_completed, CONNECT_ONE_SHOT)

func _ready() -> void:
	IDependencyProvider.request_dependency_provision(_dependency_names)
	queue_free()


func _initialize_dependency_names() -> void:
	for i: int in range(_dependency_names.size()):
		var dependency_name: String = _dependency_names[i]
		_dependency_names[i] = DependencyInjectionHelper.get_resolved_dependency_name(dependency_name)


func _on_dependency_provision_completed(dependencies: Dictionary, result: Error) -> void:
	if result != OK:
		return
		
	var siblings: Array[Node] = get_parent().get_children()
	
	while not siblings.is_empty():
		var node: Node = siblings.pop_front()
		if node.name == name:
			continue
		
		_inject_dependencies(node, dependencies)
		siblings.append_array(node.get_children())


func _inject_dependencies(sibling: Node, dependencies: Dictionary) -> void:
	if not sibling.has_method(INJECT_METHOD_NAME):
		return
		
	var method_info: Dictionary = DependencyInjectionHelper.get_method_info(sibling, INJECT_METHOD_NAME)
	if method_info.is_empty():
		# Log a warning that an _inject function has no parameters.
		return
		
	var callable: Callable = Callable(sibling, INJECT_METHOD_NAME)
	var parameters: Array[Dictionary] = method_info.args
	var arguments: Array = []
	
	for parameter: Dictionary in parameters:
		var dependency_name: StringName = parameter.class_name
		var dependency_instance: Node = dependencies.get(dependency_name)
		arguments.append(dependency_instance)
		
	callable.callv(arguments)
