extends MarginContainer


#region var
@onready var areas = $Areas

var planet = null
var corners = []
var grids = {}
var center = null
#endregion


#region init
func set_attributes(input_: Dictionary) -> void:
	planet = input_.planet
	
	
	init_basic_setting()


func init_basic_setting() -> void:
	init_areas()


func init_areas() -> void:
	var n = (planet.rank + 2) * 2 - 1
	var _corners = {}
	_corners.x = [0, n - 1]
	_corners.y = [0, n - 1]
	
	center = Vector2.ONE * (n - 1) / 2
	
	areas.columns = n
	
	for _i in n:
		for _j in n:
			var input = {}
			input.continent = self
			input.grid = Vector2(_j, _i)
			
			var area = Global.scene.area.instantiate()
			areas.add_child(area)
			area.set_attributes(input)
			
			if _corners.y.has(_i) and _corners.x.has(_j):
				corners.append(area)
	
	init_area_neighbors()


func init_area_neighbors() -> void:
	for area in areas.get_children():
		for type in Global.arr.neighbor:
			for direction in Global.dict.neighbor[type]:
				var grid = direction + area.grid
				
				if grids.has(grid):
					var neighbor = grids[grid]
					
					if !area.neighbors[type].has(neighbor):
						area.neighbors[type][neighbor] = direction
						neighbor.neighbors[type][area] = -direction
						area.directions[direction] = neighbor
						neighbor.directions[-direction] = area
#endregion
