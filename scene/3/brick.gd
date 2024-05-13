extends MarginContainer


#region var
@onready var bg = $BG
@onready var index = $Index
@onready var charge = $Charge
@onready var stone = $Stone

var proprietor = null
var grid = null
var neighbors = {}
var directions = {}
var fade = null
var pillar = null
#endregion


#region init
func set_attributes(input_: Dictionary) -> void:
	proprietor = input_.proprietor
	grid = input_.grid
	
	init_basic_setting(input_)


func init_basic_setting(input_: Dictionary) -> void:
	#position = grid * Global.num.brick.a
	fade = false
	proprietor.grids[grid] = self
	
	init_bg()
	init_tokens(input_)



func init_bg() -> void:
	var style = StyleBoxFlat.new()
	style.bg_color = Color.SLATE_GRAY
	bg.set("theme_override_styles/panel", style)


func init_tokens(input_: Dictionary) -> void:
	var input = {}
	input.proprietor = self
	input.type = "stone"
	input.subtype = "charge"
	charge.set_attributes(input)
	charge.custom_minimum_size = Global.vec.size.brick
	
	input.subtype = input_.stone.type
	input.value = input_.stone.value
	stone.set_attributes(input)
	stone.custom_minimum_size = Global.vec.size.brick
	
	input.type = "index"
	input.subtype = "brick"
	input.value = proprietor.grids.keys().size() - 1
	index.set_attributes(input)
	index.custom_minimum_size = Global.vec.size.brick



func set_fade(fade_: bool) -> void:
	fade = fade_
	
	if fade:
		visible = false


func set_pillar(pillar_: MarginContainer) -> void:
	pillar = pillar_
	
	#recolor_based_on_pillar()


func recolor_based_on_pillar() -> void:
	var h = float(pillar.get_index()) / proprietor.ruin.pillars.get_child_count()
	bg.color = Color.from_hsv(h, 0.75, 1.0)


func get_available_neighbors() -> Array:
	var available = []
	
	for neighbor in neighbors:
		if !neighbor.fade and neighbor.pillar == null:
			available.append(neighbor)
	
	return available


func get_count_available_neighbors() -> int:
	var available = 0
	
	for neighbor in neighbors:
		if !neighbor.fade and neighbor.pillar == null:
			available += 1
	
	return available 


func clean() -> void:
	for neighbor in neighbors:
		neighbor.neighbors.erase(self)
	
	for direction in directions:
		var neighbor = directions[direction]
		neighbor.directions.erase(-direction)
	
	proprietor.grids.erase(grid)
	
	get_parent().remove_child(self)
	queue_free()
#endregion
