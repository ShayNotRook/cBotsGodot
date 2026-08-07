extends MachineBuilding

@export 
var is_active: bool = false
var item_id: String = ""
var item_quantity: int = 0

@onready var item_slot_btn: Button = %ItemSlotButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
