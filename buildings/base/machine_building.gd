class_name MachineBuilding
extends Building


signal capacity_full
signal capacity_changed(value: int)
signal upgrade_tab

enum State { MINING, FULL }  # dropped ReadyToCollect — was it actually distinct from Full in your design?


@export var capacity_max: int = 1000


var capacity_current: int = 0
var machine_state: State = State.MINING

@onready var button_container: PanelContainer = %ButtonContainer
@onready var info_button: Button = %InfoButton
@onready var upgrade_button: Button = %UpButton


func _ready() -> void:
	super._ready()
	upgrade_button.button_down.connect(_on_up_button_tapped)
	print("Machine Building Ready")
	

func interact() -> void:
	if machine_state == State.MINING:
		button_container.show()


func _on_up_button_tapped() -> void:
	GameState.upgrade_tapped.emit()

# Overrides Building's default — full capacity means tap collects, not "notify tapped"
#func interact() -> void:
	#if machine_state == State.FULL:
		#_collect()
	#else:
		#super.interact()  # falls back to Building's default: emit building_tapped (opens menu)
