# Ramer-Douglas-Peucker algorithm
The Ramer-Douglas-Peucker algorithm implementation for Godot 4 on `gdscript`.

# Example
<p align="center">
  <img width="600" src="doc/example.gif" alt="Example">
</p>

# Usage
Call static calculate function from `RamerDouglasPeucker`:

```gdscript
var simplified_points = RamerDouglasPeucker.calculate(points, epsilon) # return reduced points
```

In example:

```gdscript
var points := PackedVector2Array([Vector2(0, 0), Vector2(0, 1), Vector2(0, 2), Vector2(0, 3)])
print(RamerDouglasPeucker.calculate(points, 0.5)) # [(0, 0), (0, 3)]
```

# Screenshots
<p align="center">
  <img width="600" src="doc/screen-0.png" alt="Example Screen 0">
  <img width="600" src="doc/screen-1.png" alt="Example Screen 1">
</p>
