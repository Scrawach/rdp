extends Control
class_name Example

@onready var plot: Plot = get_node("Example/Background Panel/Foreground Panel/Plot")
@onready var distance_field: Label = get_node("Input Panel/Distance Label")
@onready var number_of_points: Label = get_node("Example/Background Panel/Number Of Point Label")

var previous_distance: float

func _ready() -> void:
	plot.generate()
	_update_number_of_points()

func _on_distance_slider_value_changed(distance: float) -> void:
	plot.simplify(distance)
	previous_distance = distance
	distance_field.text = "Distance: %s" % [distance]
	_update_number_of_points()

func _on_generate_button_pressed() -> void:
	plot.generate()
	_on_distance_slider_value_changed(previous_distance)

func _update_number_of_points() -> void:
	number_of_points.text = "Number of points: %s" % plot.simplified_points.size()
