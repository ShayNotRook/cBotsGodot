extends Node

signal resource_changed(material_id: String, value: int, percentage: float)
signal upgrade_tapped

var resources: Dictionary = {"wood": 0, "stone": 0}
var max_storage: Dictionary = {"wood": 100, "stone": 100}


func add_resource(material_id: String, amount: int) -> void:
	if not resources.has(material_id):
		push_error("Unknown material: " + material_id)
		return
	resources[material_id] = min(resources[material_id] + amount, max_storage[material_id])
	var percentage: float = float(resources[material_id]) / max_storage[material_id]
	emit_signal("resource_changed", material_id, resources[material_id], percentage)

func get_resource(material_id: String) -> int:
	return resources.get(material_id, 0)


func show_upgrade_tab() -> void:
	upgrade_tapped.emit()


# --- PLACEHOLDER: gameplay, near-term ---
func spend_resource(material_id: String, amount: int) -> bool:
	# TODO: for confirmation-panel purchases/upgrades — check resources[material_id] >= amount,
	# subtract if affordable, emit resource_changed, return true/false for success.
	# This is the function your Door/upgrade-tab confirmation logic should call.
	return false


func raise_max_storage(material_id: String, amount: int) -> void:
	# TODO: called when a Storage building is placed/upgraded — increases max_storage[material_id].
	# Ties into the open question: does each Storage building raise the global cap?
	pass


# --- PLACEHOLDER: backend, later ---
func sync_from_server(server_state: Dictionary) -> void:
	# TODO: reconcile local `resources`/`max_storage` with authoritative FastAPI response.
	# Called after any server round-trip; overwrites local values and re-emits resource_changed
	# for anything that differs, so UI updates without every caller re-wiring itself.
	pass


func request_add_resource(material_id: String, amount: int) -> void:
	# TODO: eventually replaces direct add_resource() calls from buildings —
	# sends the action to FastAPI, applies optimistic local update immediately,
	# reconciles via sync_from_server() when the response returns.
	pass
