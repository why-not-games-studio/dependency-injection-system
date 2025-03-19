class_name DependencyInjectionHelper
extends Node


static var _class_info_dict: Dictionary[StringName, Dictionary]


static func _static_init() -> void:
	for class_dict: Dictionary in ProjectSettings.get_global_class_list():
		_class_info_dict[class_dict.class] = class_dict


static func get_resolved_dependency_name(dependency_name: StringName) -> StringName:
	if not _class_info_dict.has(dependency_name):
		return ""
		
	# We get the base class name because all scripts with 
	# class_name defined have one in the global class list. 
	# We check if base class name is custom against the ClassDB because
	# only pre-defined engine classes exist there.
	var base_class_name: StringName = _class_info_dict.get(dependency_name).base
	if ClassDB.class_exists(base_class_name):
		return dependency_name
	
	var resolved_dependency_name: StringName = str(base_class_name, "/", dependency_name)
	return resolved_dependency_name


static func get_method_info(node: Node, method_name: StringName) -> Dictionary:
	var method_list: Array[Dictionary] = node.get_method_list()
	for method: Dictionary in method_list:
		if method.name == method_name:
			return method
	return {}
