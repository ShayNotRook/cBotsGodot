extends MachineBuilding

signal collected(quantity: int)
signal rate_progressed(value: float)

@export var cycle_duration: float = 5.0

var rate_progress: float = 0.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	if machine_state == State.FULL:
		return
	rate_progress += delta / cycle_duration
	if rate_progress >= 1.0:
		rate_progress -= 1.0
		_add_chunk()
	progress_bar.value = rate_progress * 100.0
	rate_progressed.emit(rate_progress)


func _add_chunk() -> void:
	capacity_current = min(capacity_current + chunk_amount, capacity_max)
	capacity_changed.emit(capacity_current)
	capacity_bar.value = (float(capacity_current) / capacity_max) * 100.0
	if capacity_current >= capacity_max:
		machine_state = State.FULL
		capacity_full.emit()


func _collect() -> void:
	GameState.add_resource(out_item_id, capacity_current)
	collected.emit(capacity_current)
	capacity_current = 0
	capacity_bar.value = 0
	machine_state = State.MINING
