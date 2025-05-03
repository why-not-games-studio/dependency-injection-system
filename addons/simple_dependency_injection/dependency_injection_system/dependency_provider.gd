## Automatically provides the required node dependencies for valid injectables when they are added 
## to the [SceneTree]. [br][br]
## [u]Keep in mind[/u] that [i]_inject[/i] and [i]_post-inject[/i] calls happen after [i]_ready.[/i]
class_name DependencyProvider
extends Node


const INJECT_METHOD_NAME: StringName = "_inject"
const POST_INJECT_METHOD_NAME: StringName = "_post_inject"

@export_category("Dependencies")
@export var _dependency_registrar: DependencyRegistrarBase

var _injectables: Array[Node]
var _post_injectables: Array[Node]

var _injection_scheduled: bool


func _enter_tree() -> void:
	get_tree().node_added.connect(_register_injectable)

func _exit_tree() -> void:
	get_tree().node_added.disconnect(_register_injectable)


## Sets the dependency registrar instance.
func set_dependency_registrar(dependency_registrar: DependencyRegistrarBase) -> void:
	_dependency_registrar = dependency_registrar


func _register_injectable(node: Node) -> void:
	var is_injectable: bool = false
	
	if node.has_method(INJECT_METHOD_NAME):
		_injectables.append(node)
		is_injectable = true
		
	if node.has_method(POST_INJECT_METHOD_NAME):
		_post_injectables.append(node)
		is_injectable = true
	
	if is_injectable and not _injection_scheduled:
		_injection_scheduled = true
		_schedule_dependency_injection()


func _schedule_dependency_injection() -> void:
	await get_tree().process_frame
	_inject_dependencies()


func _inject_dependencies() -> void:
	for injectable: Node in _injectables:
		var method_info: Dictionary = DependencyInjectionHelper \
			.get_method_info(injectable, INJECT_METHOD_NAME)
		if method_info.args.is_empty():
			push_warning("The '[%s]' function on [%s] has no parameters." \
			% [INJECT_METHOD_NAME, injectable.name])
			continue
		
		var callable: Callable = Callable(injectable, INJECT_METHOD_NAME)
		var arguments: Array = []
		
		for parameter: Dictionary in method_info.args:

			var dependency_name: StringName = DependencyInjectionHelper \
				.get_resolved_dependency_name(parameter.name.to_pascal_case())
			arguments.append(_dependency_registrar.get_dependency(dependency_name))
			
		callable.callv(arguments)
	for post_injectable: Node in _post_injectables:
		post_injectable._post_inject()
	
	_injectables.clear()
	_post_injectables.clear()
	
	_injection_scheduled = false
