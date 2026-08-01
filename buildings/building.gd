class_name Building
extends Node

signal building_tapped(building: Building)

@export var machine_id: int = 0
@export var display_name: String = ""
@export var description: String = ""

@onready var tap_area: Area2D = %TapArea

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	tap_area.input_pickable = true
	tap_area.input_event.connect(_on_tap_area_event)

func _on_tap_area_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventScreenTouch and event.is_pressed():
		interact()

# Default behavior: notify whoever's listening (resolver / UI) that this was tapped.
# Subclasses override this to do something else instead of calling super.
func interact() -> void:
	building_tapped.emit(self)
