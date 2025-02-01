@tool
class_name GameManager
extends GameManagerBase


@export_category("Members")
@export var _initial_game_state: GameStateBase:
	get:
		return _initial_game_state
	set(value):
		_initial_game_state = value
		
		if Engine.is_editor_hint():
			update_configuration_warnings()
			
@export var _game_states: Array[GameStateBase]:
	get:
		return _game_states
	set(value):
		_game_states = value
		
		if Engine.is_editor_hint():
			update_configuration_warnings()

var _current_game_state: GameStateBase
var _game_state_dict: Dictionary # Dictionary[StringName, GameStateBase]


func _get_configuration_warnings() -> PackedStringArray:
	var warnings: PackedStringArray
	
	if _initial_game_state == null:
		warnings.append("Initial state must be set.")
	if _game_states == null or _game_states.is_empty():
		warnings.append("There are no game states: Ignore this warning if this is deliberate.")

	return warnings


func _enter_tree() -> void:
	if not Engine.is_editor_hint():
		_initialize_game_states()


func _ready() -> void:
	if not Engine.is_editor_hint():
		_enter_initial_game_state()


func _exit_tree() -> void:
	if not Engine.is_editor_hint():
		_deinitialize_current_game_state()
		_clear_game_states()


func _initialize_game_states() -> void:
	for game_state: GameStateBase in _game_states:
		_game_state_dict[game_state.name] = game_state


func _enter_initial_game_state() -> void:
	_current_game_state = _initial_game_state
	_current_game_state.enter_state(null)


func _deinitialize_current_game_state() -> void:
	if _current_game_state != null:
		_current_game_state.exit_state()
		_current_game_state = null


func _clear_game_states() -> void:
	_game_state_dict.clear()


func change_game_state(game_state_name: StringName) -> void:
	if _game_state_dict.has(game_state_name):
		var prev_state: GameStateBase
		if _current_game_state != null:
			prev_state = _current_game_state
			prev_state.exit_state()
			
		_current_game_state = _game_state_dict[game_state_name]
		_current_game_state.enter_state(prev_state)
