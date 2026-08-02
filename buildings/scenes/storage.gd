class_name Storage
extends MachineBuilding

var TEST_MAX: int = 10

@export var material_type: String = ""
@export var current_capacity: int = 0
#@export var capacity_max: int = 100


@onready var storage_bar: ProgressBar = %CapacityBar

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	if material_type == "":
		push_warning(name + ": material_type is not set!")
	GameState.resource_changed.connect(_on_resource_changed)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

func _on_resource_changed(material_id: String, value: int, percentage: float) -> void:
	if material_id != material_type:
		return
	storage_bar.value = percentage * 100.0



func interact() -> void:
	# TODO: decide what tapping storage should do — open a transfer/info UI?
	# For now falls back to default building_tapped signal.
	super.interact()


# --- PLACEHOLDER: gameplay, near-term ---
func contribute_to_max_storage() -> void:
	# TODO: on _ready(), call GameState.raise_max_storage(material_type, capacity_max)
	# if you decide storage buildings should raise the global cap (open design question).
	pass


# --- PLACEHOLDER: backend, later ---
func sync_state(server_data: Dictionary) -> void:
	# TODO: reconcile current_capacity with server truth.
	pass
