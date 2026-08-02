class_name MachineBuilding
extends Building


signal capacity_full
signal capacity_changed(value: int)


enum State { MINING, FULL }  # dropped ReadyToCollect — was it actually distinct from Full in your design?


@export var capacity_max: int = 1000


var capacity_current: int = 0
var machine_state: State = State.MINING

func _ready() -> void:
	super._ready()
	print("Machine Building Ready")


func interact() -> void:
	pass

# Overrides Building's default — full capacity means tap collects, not "notify tapped"
#func interact() -> void:
	#if machine_state == State.FULL:
		#_collect()
	#else:
		#super.interact()  # falls back to Building's default: emit building_tapped (opens menu)
