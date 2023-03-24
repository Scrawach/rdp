extends Control
class_name Plot

const POINTS_BORDER: Vector2 = Vector2(3, 15)
const SPLINE_DENSITY: float = 10.0

const PRIMARY_GRID_STEP: Vector2 = Vector2(20, 20)
const SECONDARY_GRID_STEP: Vector2 = Vector2(100, 100)

@export var primary_grid_color: Color
@export var secondary_grid_color: Color
@export var chart_color: Color
@export var font: Font = FontVariation.new()
@export var font_size: int = 14

var chart_points: PackedVector2Array
var simplified_points: PackedVector2Array

func simplify(distance: float) -> void:
	simplified_points = RamerDouglasPeucker.calculate(chart_points, distance)
	queue_redraw()

func generate() -> void:
	var max_visible_amount_of_points: int = ceil(size.x / PRIMARY_GRID_STEP.x) + 1
	chart_points = PointGenerator.generate_splined(max_visible_amount_of_points, POINTS_BORDER, SPLINE_DENSITY)
	simplified_points = chart_points
	queue_redraw()

func _draw() -> void:
	_draw_grid(PRIMARY_GRID_STEP, primary_grid_color)
	_draw_grid(SECONDARY_GRID_STEP, secondary_grid_color)
	_draw_grid_numbers(SECONDARY_GRID_STEP, secondary_grid_color, font, font_size)
	
	if chart_points.size() > 1:
		_draw_chart(simplified_points, chart_color)

func _draw_grid(step: Vector2, color: Color) -> void:
	var x = step.x
	while x < size.x:
		draw_line(Vector2(x, 0), Vector2(x, size.y), color)
		x += step.x
	
	var y = size.y
	while y > 0:
		draw_line(Vector2(0, y), Vector2(size.x, y), color)
		y -= step.y

func _draw_grid_numbers(step: Vector2, color: Color, font: Font, font_size: int) -> void:
	const LINE_OFFSET: int = 5
	var height = size.y - font_size / 2.0
	var x = 0
	while x < size.x:
		var text = str(int(x / PRIMARY_GRID_STEP.x))
		var point = Vector2(x + LINE_OFFSET, height)
		draw_string(font, point, text, HORIZONTAL_ALIGNMENT_LEFT, -1, font_size, color)
		x += step.x

func _draw_chart(points: PackedVector2Array, color: Color) -> void:
	var render_pixel_points := PackedVector2Array()
	
	for point in points:
		var pixel_point = point * PRIMARY_GRID_STEP
		pixel_point.y = size.y - pixel_point.y
		render_pixel_points.push_back(pixel_point)
		draw_circle(pixel_point, 2, color)
	
	draw_polyline(render_pixel_points, color, 1, true)
	_draw_chart_background(render_pixel_points, color, size.y, 0.7)

func _draw_chart_background(points: PackedVector2Array, color: Color, max_height: float, gradient_strength: float) -> void:
	var polygon := PackedVector2Array()
	
	polygon.append(Vector2(0, size.y))
	polygon.append_array(points)
	polygon.append(Vector2(points[-1].x, size.y))
	
	var colors := PackedColorArray()
	for point in polygon:
		var computed = color
		var progress = 1 - point.y / (max_height)
		computed.a *= progress * gradient_strength
		colors.push_back(computed)
	
	draw_polygon(polygon, colors)
