extends MarginContainer


#region vars
@onready var index = $VBox/Index
@onready var domain = $VBox/Domain

var pantheon = null
var planet = null
#endregion


#region init
func set_attributes(input_: Dictionary) -> void:
	pantheon = input_.pantheon
	
	init_basic_setting()


func init_basic_setting() -> void:
	Global.num.index.god += 1
	
	var input = {}
	input.proprietor = self
	input.type = "index"
	input.subtype = "god"
	input.value = Global.num.index.god
	index.set_attributes(input)
	
	input.god = self
	domain.set_attributes(input)
#endregion
