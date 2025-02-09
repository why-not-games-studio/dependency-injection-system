# Global - ILogger
class_name LoggerInterface
extends Node


signal debug_message_log_requested(message: String, sender: String)
signal info_message_log_requested(message: String, sender: String)
signal warn_message_log_requested(message: String, sender: String)
signal error_message_log_requested(message: String, sender: String)
signal critical_message_log_requested(message: String, sender: String)


func log_debug(message: String, sender: String) -> void:
	debug_message_log_requested.emit(message, sender)


func log_info(message: String, sender: String) -> void:
	info_message_log_requested.emit(message, sender)


func log_warn(message: String, sender: String) -> void:
	warn_message_log_requested.emit(message, sender)


func log_error(message: String, sender: String) -> void:
	error_message_log_requested.emit(message, sender)


func log_critical(message: String, sender: String) -> void:
	critical_message_log_requested.emit(message, sender)
