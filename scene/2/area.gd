extends MarginContainer


#region var
@onready var bg = $BG

var continent = null
var grid = null
var neighbors = {}
var directions = {}
var domains = []
#endregion


#region init
func set_attributes(input_: Dictionary) -> void:
	continent = input_.continent
	grid = input_.grid
	
	init_basic_setting()


func init_basic_setting() -> void:
	custom_minimum_size = Global.vec.size.area
	continent.grids[grid] = self
	init_bg()
	
	
	for type in Global.arr.neighbor:
		neighbors[type] = {}


func init_bg() -> void:
	var style = StyleBoxFlat.new()
	style.bg_color = Color.SLATE_GRAY
	bg.set("theme_override_styles/panel", style)


func recolor_based_on_domain(domain_: MarginContainer) -> void:
	var h = float(domain_.god.get_index()) / continent.planet.gods.get_child_count()
	var style = bg.get("theme_override_styles/panel")
	style.bg_color = Color.from_hsv(h, 0.5, 0.9)


func recolor_based_on_density() -> void:
	var v = 1 - float(domains.size()) / continent.planet.gods.get_child_count()
	var style = bg.get("theme_override_styles/panel")
	style.bg_color = Color.from_hsv(0, 0.0, v)
#endregion
