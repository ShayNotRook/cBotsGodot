extends Control  # or Node2D, depending on whether this bar lives in a CanvasLayer/HUD or world-space —
				  # you flagged this as an open question earlier; pick based on where you actually place it

@export var material_type: String = ""  # e.g. "coin", "wood" — which resource this bar watches
@export var show_as_count: bool = false  # true: display raw number instead of/alongside percentage

@onready var bar: TextureProgressBar = %Bar
#@onready var label: Label = %Label  # optional —  if this bar has no text, just fill


func _ready() -> void:
	if material_type == "":
		push_warning(name + ": material_type is not set!")
		return

	GameState.resource_changed.connect(_on_resource_changed)

	# initialize to current value immediately, don't wait for the next change
	var current: int = GameState.get_resource(material_type)
	var max_value: int = GameState.max_storage.get(material_type, 1)
	_update_bar(current, float(current) / max_value)


func _on_resource_changed(material_id: String, value: int, percentage: float) -> void:
	if material_id != material_type:
		return
	_update_bar(value, percentage)


func _update_bar(value: int, percentage: float) -> void:
	bar.value = percentage * 100.0
	#if label:
		#label.text = str(value) if show_as_count else str(int(percentage * 100)) + "%"


# --- PLACEHOLDER: gameplay, near-term ---
func _on_bar_full() -> void:
	# TODO: decide if hitting 100% should trigger any feedback here (pulse animation, glow),
	# or if that belongs to GameState/whatever's producing the resource instead.
	pass


# --- PLACEHOLDER: backend, later ---
# No backend-specific logic expected here — this bar only ever reflects
# GameState's local cache, which itself gets reconciled via sync_from_server().
# If you later want optimistic-update visual distinction (e.g. bar shown
# slightly translucent while awaiting server confirmation), that'd go here.
