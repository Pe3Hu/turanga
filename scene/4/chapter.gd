extends MarginContainer


#region var
@onready var bg = $BG
@onready var damage = $HBox/Tags/Damage
@onready var block = $HBox/Tags/Block
@onready var heal = $HBox/Tags/Heal

var book = null
var bricks = null
#endregion


#region init
func set_attributes(input_: Dictionary) -> void:
	book = input_.book
	bricks = input_.bricks
	
	init_basic_setting()


func init_basic_setting() -> void:
	init_bg()
	init_tokens()


func init_bg() -> void:
	var style = StyleBoxFlat.new()
	style.bg_color = Color.SLATE_GRAY
	bg.set("theme_override_styles/panel", style)


func init_tokens() -> void:
	for subtype in Global.arr.tag:
		var input = {}
		input.proprietor = self
		input.type = "stone"
		input.subtype = subtype
		input.value = 0
		
		var token = get(subtype)
		token.set_attributes(input)
		token.custom_minimum_size = Global.vec.size.brick
	
	for brick in bricks:
		var tag = get(brick.stone.subtype)
		var value = brick.stone.get_value()
		tag.change_value(value)
		
		if !tag.visible:
			tag.visible = true
#endregion

