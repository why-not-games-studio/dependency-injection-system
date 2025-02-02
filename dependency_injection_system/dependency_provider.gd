## Default implementation of a DependencyProvider which 
## provides dependencies for all dependency injectors.
## Relies on DependencyProviderInterface.
class_name DependencyProvider
extends Node


@export_category("Members")
@export var _dependencies: Array[Node]

var _dependencies_dict: Dictionary # Dictionary[StringName, Node]


func _enter_tree() -> void:
	_connect_signals()
	_initialize_dependencies()

func _exit_tree() -> void:
	_deinitialize_dependencies()
	_disconnect_signals()


func _connect_signals() -> void:
	IDependencyProvider.dependency_registration_requested \
		.connect(_register_dependency)
	IDependencyProvider.dependency_deregistration_requested \
		.connect(_deregister_dependency)
	
	IDependencyProvider.dependency_provision_requested \
		.connect(_resolve_dependency_provision)

func _disconnect_signals() -> void:
	IDependencyProvider.dependency_registration_requested \
		.disconnect(_register_dependency)
	IDependencyProvider.dependency_deregistration_requested \
		.disconnect(_deregister_dependency)
	
	IDependencyProvider.dependency_provision_requested \
		.disconnect(_resolve_dependency_provision)


func _initialize_dependencies() -> void:
	for dependency: Node in _dependencies:
		_register_dependency(dependency)
	_dependencies.clear()

func _deinitialize_dependencies() -> void:
	_dependencies_dict.clear()


func _register_dependency(dependency: Node) -> void:
	if dependency == null:
		# Log an Error
		return
		
	var dependency_name: StringName = DependencyInjectionHelper \
		.get_resolved_dependency_name(dependency.name)
	_dependencies_dict[dependency_name] = dependency

func _deregister_dependency(dependency_name: StringName) -> void:
	if dependency_name == "":
		# Log an Error
		return
	
	dependency_name = DependencyInjectionHelper \
		.get_resolved_dependency_name(dependency_name)
	if _dependencies_dict.has(dependency_name):
		_dependencies_dict.erase(dependency_name)


func _resolve_dependency_provision(dependency_names: Array[StringName]) -> void:
	var dependencies: Dictionary # Dictionary[StringName, Node]
	
	for dependency_name: StringName in dependency_names:
		if not _dependencies_dict.has(dependency_name):
			# Log an Error
			IDependencyProvider.fail_dependency_provision(ERR_DOES_NOT_EXIST)
			return
			
		var dependency: Node = _dependencies_dict.get(dependency_name)
		if dependency == null:
			# Log an Error
			IDependencyProvider.fail_dependency_injection(ERR_UNAVAILABLE)
			return
			
		dependencies[dependency_name] = dependency
	
	IDependencyProvider.succeed_dependency_provision(dependencies)
