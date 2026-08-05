extends PanelContainer

@onready var area_tab: Area2D = %CloseArea

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area_tab.input_pickable = true
	area_tab.input_event.connect(_on_close_tapped)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_close_tapped() -> void:
	self.hide()
