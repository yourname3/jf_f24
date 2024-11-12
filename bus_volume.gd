extends HSlider

@export var bus: StringName = "Music"

@onready var bus_idx = AudioServer.get_bus_index(bus)

func _value_changed(value: float):
	AudioServer.set_bus_volume_db(bus_idx, linear_to_db(value))

func _ready():
	min_value = 0
	max_value = 1
	step = 0.001
	
	value = db_to_linear(AudioServer.get_bus_volume_db(bus_idx))
	
	value_changed.connect(_value_changed)
