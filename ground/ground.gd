@tool
extends Node2D
class_name Ground

@export var terrain_line: Line2D:
	set(value):
		terrain_line = value
		update_ground()

@onready var collision_polygon_2d: CollisionPolygon2D = %CollisionPolygon2D
@onready var polygon_2d: Polygon2D = %Polygon2D

func _ready():
	update_ground()

func update_ground():
	if not is_inside_tree():
		return

	var viewport_width = ProjectSettings.get_setting("display/window/size/viewport_width")
	var viewport_height = ProjectSettings.get_setting("display/window/size/viewport_height")

	var points: PackedVector2Array = PackedVector2Array()
	
	if terrain_line and terrain_line.points.size() >= 2:
		# Convertir les points en coordonnées locales du Ground
		var local_points: Array[Vector2] = []
		for point in terrain_line.points:
			var global_point = terrain_line.to_global(point)
			var local_point = to_local(global_point)
			local_points.append(local_point)
		
		var first_point = local_points[0]
		var last_point = local_points[local_points.size() - 1]
		
		# 1. Commencer au bord gauche
		if first_point.x > 0:
			points.append(Vector2(0, first_point.y))
		
		# 2. Ajouter tous les points du relief
		for point in local_points:
			points.append(point)
		
		# 3. Étendre au bord droit
		if last_point.x < viewport_width:
			points.append(Vector2(viewport_width, last_point.y))
		
		# Trouver le point le plus bas du relief
		var max_y = local_points[0].y
		for point in local_points:
			if point.y > max_y:
				max_y = point.y
	
		
		# Fermer par le bas du viewport
		points.append(Vector2(viewport_width, viewport_height))
		points.append(Vector2(0, viewport_height))
	else:
		points = PackedVector2Array([
			Vector2(0, 0),
			Vector2(viewport_width, 0),
			Vector2(viewport_width, viewport_height),
			Vector2(0, viewport_height)
		])
	
	if collision_polygon_2d:
		collision_polygon_2d.polygon = points
	if polygon_2d:
		polygon_2d.polygon = points
