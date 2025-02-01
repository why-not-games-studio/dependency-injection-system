class_name Logger
extends Node

enum LogLevel {
	DEBUG,
	INFO,
	WARN,
	ERROR,
	CRITICAL,
}


const MAXIMUM_LOG_COUNT: int = 250
const LOG_LEVEL_TEXTS: Dictionary = {
	LogLevel.DEBUG: "DBG",
	LogLevel.INFO: "INF",
	LogLevel.WARN: "WRN",
	LogLevel.ERROR: "ERR",
	LogLevel.CRITICAL: "CRT",
} # Dictionary[LogLevel, String]

var _folder_name: String = "saved_logs"
var _folder_path: String
var _session_number: int
var _log_file_path: String

var _log_messages: Array[String]


func _enter_tree() -> void:
	_connect_signals()
	
	_set_folder_path()
	_set_session_number()
	_set_log_file_path()


func _exit_tree() -> void:
	_disconnect_signals()
	
	if _log_messages:
		_ensure_log_folder_and_file_created(_log_file_path)
		_write_logs_to_file(_log_file_path)


func _connect_signals() -> void:
	ILogger.debug_message_log_requested.connect(_log_debug)
	ILogger.info_message_log_requested.connect(_log_info)
	ILogger.warn_message_log_requested.connect(_log_warn)
	ILogger.error_message_log_requested.connect(_log_error)
	ILogger.critical_message_log_requested.connect(_log_critical)


func _disconnect_signals() -> void:
	ILogger.debug_message_log_requested.disconnect(_log_debug)
	ILogger.info_message_log_requested.disconnect(_log_info)
	ILogger.warn_message_log_requested.disconnect(_log_warn)
	ILogger.error_message_log_requested.disconnect(_log_error)
	ILogger.critical_message_log_requested.disconnect(_log_critical)


func _set_folder_path() -> void: 
	_folder_path = ProjectSettings.globalize_path("user://" + _folder_name)
	_folder_path = str(_folder_path, "/", _get_current_date(), "_logs")


func _set_session_number() -> void:
	var dir: DirAccess = DirAccess.open(_folder_path)
	_session_number = dir.get_files().size() if dir != null else 0


func _set_log_file_path() -> void:
	_log_file_path = str(_folder_path, "/", _get_current_date(), "_log_", _session_number + 1, ".log")


func _get_current_date() -> String:
	return Time.get_date_string_from_system()


func _ensure_log_folder_and_file_created(log_file_path: String) -> void:
	_create_log_folder()
	_create_log_file(log_file_path)


func _write_logs_to_file(log_file_path: String) -> void:
	if _log_messages.is_empty():
		return
	
	var file: FileAccess = FileAccess.open(log_file_path, FileAccess.READ_WRITE)
	if file == null:
		printerr("Failed to open log file: ", log_file_path)
		return
	
	file.seek_end()
	
	for log_message: String in _log_messages:
		file.store_line(log_message)
	
	file.close()
	_log_messages.clear()


func _create_log_folder() -> void:
	var dir: DirAccess = DirAccess.open(_folder_path)
	if dir == null:
		DirAccess.make_dir_recursive_absolute(_folder_path)


func _create_log_file(log_file_path: String) -> void:
	if not FileAccess.file_exists(log_file_path):
		var file: FileAccess = FileAccess.open(log_file_path, FileAccess.WRITE)
		file.close()


func _log_debug(message: String, sender: String) -> void:
	var log_content: String = _format_log_message(LogLevel.DEBUG, message, sender)
	print_rich(str("[color=#D1ACFB]", log_content, "[/color]"))


func _log_info(message: String, sender: String) -> void:
	var log_content: String = _format_log_message(LogLevel.INFO, message, sender)
	print_rich(str("[color=#A9FFFF]", log_content, "[/color]"))
	_add_log_message(log_content)


func _log_warn(message: String, sender: String) -> void:
	var log_content: String = _format_log_message(LogLevel.WARN, message, sender)
	print_rich(str("[color=#E7CB60]", log_content, "[/color]"))
	_add_log_message(log_content)


func _log_error(message: String, sender: String) -> void:
	var log_content: String = _format_log_message(LogLevel.ERROR, message, sender)
	printerr(log_content)
	_add_log_message(log_content)


func _log_critical(message: String, sender: String) -> void:
	var log_content: String = _format_log_message(LogLevel.CRITICAL, message, sender)
	printerr(log_content)
	_add_log_message(log_content)


func _format_log_message(log_level: LogLevel, message: String, sender: String) -> String:
	return str("[", _get_current_time(), " ", _get_log_level_text(log_level), " from ", sender, "]: ", message)


func _add_log_message(log_content: String) -> void:
	_log_messages.append(log_content)
	
	if _log_messages.size() >= MAXIMUM_LOG_COUNT:
		_ensure_log_folder_and_file_created(_log_file_path)
		_write_logs_to_file(_log_file_path)


func _get_current_time() -> String:
	return Time.get_time_string_from_system()


func _get_log_level_text(log_level: int) -> String:
	return LOG_LEVEL_TEXTS[log_level]
