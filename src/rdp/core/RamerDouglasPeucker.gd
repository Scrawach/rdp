extends Object
class_name RamerDouglasPeucker

# Reduce number of points in array using Ramer-Douglas-Peucker algorithm
# Ramer-Douglas-Peucker algorithm: https://en.wikipedia.org/wiki/Ramer%E2%80%93Douglas%E2%80%93Peucker_algorithm
static func calculate(points: PackedVector2Array, epsilon: float) -> PackedVector2Array:
	if points.size() < 3:
		return points
	var epsilon_squared = pow(epsilon, 2)
	return _simplify(points, 0, points.size() - 1, epsilon_squared)

# Recursive calculation
static func _simplify(points: PackedVector2Array, start: int, end: int, epsilon_squared: float) -> PackedVector2Array:
	var max_distance_squared = 0
	var index = 0
	
	for i in range(start, end + 1):
		var distance = _perpendicular_squared(points[i], points[start], points[end])
		if distance > max_distance_squared:
			max_distance_squared = distance
			index = i
	
	if max_distance_squared <= epsilon_squared:
		return PackedVector2Array([points[start], points[end]])
	
	var result_1 = _simplify(points, start, index, epsilon_squared)
	var result_2 = _simplify(points, index, end, epsilon_squared)
	var sum = result_1.slice(0, result_1.size() - 1) + result_2
	return sum

static func _perpendicular_squared(target: Vector2, p1: Vector2, p2: Vector2) -> float:
	var to_target = target - p1
	var to_end = p2 - p1
	var project = to_target.project(to_end)
	var distance = to_target.length_squared() - project.length_squared()
	return distance
