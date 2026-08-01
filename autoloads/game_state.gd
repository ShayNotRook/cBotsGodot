extends Node

signal resource_changed(material_id: String, value: int, percentage: float)


var resources: Dictionary = {"wood": 0, "stone": 0}
var max_storage: Dictionary = {"wood": 100, "stone": 100}

# Called when the node enters the scene tree for the first time.
func add_resource(material_id: String, amount: int) -> void:
	if not resources.has(material_id):
		push_error("Unknown material: " + material_id)
		return

	resources[material_id] = min(resources[material_id] + amount, max_storage[material_id])
	# ??? — compute percentage here: current / max, as a 0.0–1.0 float
	var percentage: float = 0.0  # fill this in
	emit_signal("resource_changed", material_id, resources[material_id], percentage)
