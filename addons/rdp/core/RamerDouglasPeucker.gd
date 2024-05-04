extends Object
class_name RamerDouglasPeucker

# Reduce number of points in array using Ramer-Douglas-Peucker algorithm
# Ramer-Douglas-Peucker algorithm: https://en.wikipedia.org/wiki/Ramer%E2%80%93Douglas%E2%80%93Peucker_algorithm
static func calculate(points: PackedVector2Array, epsilon: float) -> PackedVector2Array:
	if points.size() < 3:
		return points.duplicate()
	var epsilon_squared = pow(epsilon, 2)
	var result := PackedVector2Array()
	_simplify(result, points, 0, points.size() - 1, epsilon_squared)
	result.append(points[-1])
	return result

# Recursive calculation
static func _simplify(result: PackedVector2Array, points: PackedVector2Array, start: int, end: int, epsilon_squared: float) -> void:
	var max_distance_squared = 0
	var index = 0
	
	for i in range(start, end + 1):
		var distance = _perpendicular_squared(points[i], points[start], points[end])
		if distance > max_distance_squared:
			max_distance_squared = distance
			index = i
	
	if max_distance_squared <= epsilon_squared:
		result.append(points[start])
	else:
		_simplify(result, points, start, index, epsilon_squared)
		_simplify(result, points, index, end, epsilon_squared)

static func _perpendicular_squared(target: Vector2, p1: Vector2, p2: Vector2) -> float:
	var to_target = target - p1
	var to_end = p2 - p1
	var project = to_target.project(to_end)
	return to_target.length_squared() - project.length_squared()
