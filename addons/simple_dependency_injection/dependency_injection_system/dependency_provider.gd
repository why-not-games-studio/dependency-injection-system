## Default implementation of a DependencyProvider which 
## provides dependencies for all injectables.
## Relies on Global Autoload [IDependencyProvider].
@tool
class_name DependencyProvider
extends Node


const INJECT_METHOD_NAME: StringName = "_inject"

@export_category("Members")
@export var _dependencies: Array[Node]:
	get:
		return _dependencies
	set(value):
		_dependencies = value
		
		if Engine.is_editor_hint():
			update_configuration_warnings()

var _dependencies_dict: Dictionary[StringName, Node]
var _injectables: Array[Node]


func _get_configuration_warnings() -> PackedStringArray:
	var warnings: PackedStringArray = []

	for dependency: Node in _dependencies:
		if dependency == null:
			warnings.append("There cannot be an unassigned Dependency node.")
			break
	
	return warnings


func _enter_tree() -> void:
	if not Engine.is_editor_hint():
		_connect_signals()
		_initialize_dependencies()

func _ready() -> void:
	if not Engine.is_editor_hint():
		_inject_dependencies()

func _exit_tree() -> void:
	if not Engine.is_editor_hint():
		_deinitialize_dependencies()
		_disconnect_signals()


func _connect_signals() -> void:
	get_tree().node_added.connect(_register_injectable)
	
	IDependencyProvider.dependency_registration_requested \
		.connect(_register_dependency)
	IDependencyProvider.dependency_deregistration_requested \
		.connect(_deregister_dependency)
	
	IDependencyProvider.dependency_injection_requested \
		.connect(_inject_dependencies)

func _disconnect_signals() -> void:
	get_tree().node_added.disconnect(_register_injectable)
	
	IDependencyProvider.dependency_registration_requested \
		.disconnect(_register_dependency)
	IDependencyProvider.dependency_deregistration_requested \
		.disconnect(_deregister_dependency)
	
	IDependencyProvider.dependency_injection_requested \
		.disconnect(_inject_dependencies)


func _initialize_dependencies() -> void:
	for dependency: Node in _dependencies:
		_register_dependency(dependency)
	_dependencies.clear()

func _deinitialize_dependencies() -> void:
	_dependencies_dict.clear()


func _register_injectable(node: Node) -> void:
	if not node.has_method(INJECT_METHOD_NAME):
		return
		
	_injectables.append(node)


func _register_dependency(dependency: Node) -> void:
	if dependency == null:
		push_warning("The 'dependency' passed cannot be null.")
		return
		
	var dependency_name: StringName = DependencyInjectionHelper \
		.get_resolved_dependency_name(dependency.name)
	_dependencies_dict[dependency_name] = dependency

func _deregister_dependency(dependency_name: StringName) -> void:
	if dependency_name == "":
		push_warning("The 'dependency_name' passed cannot be an empty string.")
		return
	
	dependency_name = DependencyInjectionHelper \
		.get_resolved_dependency_name(dependency_name)
	_dependencies_dict.erase(dependency_name)


func _inject_dependencies() -> void:
	for injectable: Node in _injectables:
		var method_info: Dictionary = DependencyInjectionHelper \
			.get_method_info(injectable, INJECT_METHOD_NAME)
		if method_info.args.is_empty():
			push_warning(str("The '", INJECT_METHOD_NAME, "' function on [")
			, injectable.name, "] has no parameters.")
			continue
		
		var callable: Callable = Callable(injectable, INJECT_METHOD_NAME)
		var arguments: Array = []
		
		for parameter: Dictionary in method_info.args:
			var dependency_name: StringName = DependencyInjectionHelper \
				.get_resolved_dependency_name(parameter.name.to_pascal_case())
			arguments.append(_dependencies_dict.get(dependency_name))
			
		callable.callv(arguments)
	
	_injectables.clear()
