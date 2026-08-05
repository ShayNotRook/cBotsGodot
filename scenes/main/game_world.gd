extends Node2D

@onready var upgrade_container: PanelContainer = %UpgradeTabContainer
@onready var collision_close: CollisionShape2D = %CloseCollision

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameState.upgrade_tapped.connect(show_upgrade_tab)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	
func show_upgrade_tab() -> void:
	collision_close.set_deferred("disabled", 0)
	upgrade_container.show()
