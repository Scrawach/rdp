extends RefCounted
class_name PointGenerator

static func generate_splined(amount: int, bound: Vector2, density: float) -> PackedVector2Array:
	return _splined_points(generate(amount, bound), density)

static func generate(amount: int, bounds: Vector2) -> PackedVector2Array:
	var random := RandomNumberGenerator.new()
	var result := PackedVector2Array()
	
	for i in amount:
		var value = random.randf_range(bounds.x, bounds.y)
		result.push_back(Vector2(i, value))
	
	return result

static func _splined_points(points: PackedVector2Array, density: float) -> PackedVector2Array:
	var spline_points := PackedVector2Array()
	var local_points := PackedVector2Array(points)
	
	var p1 := local_points[0] 
	var p2 := local_points[-1] 
	local_points.insert(0, p1)
	local_points.push_back(p2)
	
	for p in range(1, local_points.size() - 2, 1):
		for f in range(0, density + 1, 1):
			spline_points.append(local_points[p].cubic_interpolate(local_points[p + 1], local_points[p - 1], local_points[p + 2], f / density))
	
	return spline_points
