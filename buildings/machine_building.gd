class_name MachineBuilding
extends Building

signal capacity_full
signal rate_progressed(value: float)
signal capacity_changed(value: int)
signal collected(quantity: int)

enum State { MINING, FULL }  # dropped ReadyToCollect — was it actually distinct from Full in your design?

@export var out_item_id: String = ""
@export var chunk_amount: int = 10
@export var cycle_duration: float = 5.0
@export var capacity_max: int = 1000

var rate_progress: float = 0.0
var capacity_current: int = 0
var machine_state: State = State.MINING

@onready var progress_bar: ProgressBar = %RateBar
@onready var capacity_bar: ProgressBar = %CapacityBar

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

# Overrides Building's default — full capacity means tap collects, not "notify tapped"
func interact() -> void:
	if machine_state == State.FULL:
		_collect()
	else:
		super.interact()  # falls back to Building's default: emit building_tapped (opens menu)

func _collect() -> void:
	GameState.add_resource(out_item_id, capacity_current)
	collected.emit(capacity_current)
	capacity_current = 0
	capacity_bar.value = 0
	machine_state = State.MINING
