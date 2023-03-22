extends Control
class_name Example

@onready var plot: Plot = get_node("Example/Background Panel/Foreground Panel/Plot")
@onready var distance_field: Label = get_node("Input Panel/Distance Label")

var previous_distance: float

func _ready() -> void:
    plot.generate()

func _on_distance_slider_value_changed(distance: float) -> void:
    plot.simplify(distance)
    previous_distance = distance
    distance_field.text = "Distance: %s" % [distance]

func _on_generate_button_pressed() -> void:
    plot.generate()
    plot.simplify(previous_distance)
