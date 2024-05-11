extends Node


var rng = RandomNumberGenerator.new()
var arr = {}
var num = {}
var vec = {}
var color = {}
var dict = {}
var flag = {}
var node = {}
var scene = {}


func _ready() -> void:
	init_arr()
	init_num()
	init_vec()
	init_color()
	init_dict()
	init_scene()


func init_arr() -> void:
	arr.neighbor = ["linear", "diagonal"]


func init_num() -> void:
	num.index = {}
	num.index.god = 0


func init_dict() -> void:
	init_neighbor()
	init_font()
	init_territory()
	
	init_foundation()


func init_neighbor() -> void:
	dict.neighbor = {}
	dict.neighbor.linear = [
		Vector2( 0,-1),
		Vector2( 1, 0),
		Vector2( 0, 1),
		Vector2(-1, 0)
	]
	dict.neighbor.diagonal = [
		Vector2( 1,-1),
		Vector2( 1, 1),
		Vector2(-1, 1),
		Vector2(-1,-1)
	]
	dict.neighbor.zero = [
		Vector2( 0, 0),
		Vector2( 1, 0),
		Vector2( 1, 1),
		Vector2( 0, 1)
	]


func init_font():
	dict.font = {}
	dict.font.size = {}
	dict.font.size["basic"] = 18
	dict.font.size["season"] = 18
	dict.font.size["phase"] = 18
	dict.font.size["moon"] = 18


func init_territory() -> void:
	dict.territory = {}
	dict.territory.rank = {}
	
	var description = {}
	description[1] = 4
	description[2] = 1
	description[3] = 1
	
	dict.territory.rank[1] = description
	
	for _i in range(2, 9, 1):
		description = dict.territory.rank[_i - 1].duplicate()
		
		description[1] += 1
		description[_i] += 1
		description[_i + 1] = 1
		
		dict.territory.rank[_i] = description


func init_foundation() -> void:
	dict.foundation = {}
	dict.foundation.rank = {}
	var exceptions = ["rank"]
	
	var path = "res://asset/json/turanga_foundation.json"
	var array = load_data(path)
	
	for foundation in array:
		foundation.rank = int(foundation.rank)
		var data = {}
		
		for key in foundation:
			if !exceptions.has(key) and foundation[key] > 0:
				data[int(key)] = foundation[key]
			
		if !dict.foundation.rank.has(foundation.rank):
			dict.foundation.rank[foundation.rank] = []
	
		dict.foundation.rank[foundation.rank] = data


func init_scene() -> void:
	scene.pantheon = load("res://scene/1/pantheon.tscn")
	scene.god = load("res://scene/1/god.tscn")
	
	scene.planet = load("res://scene/2/planet.tscn")
	scene.area = load("res://scene/2/area.tscn")


func init_vec():
	vec.size = {}
	vec.size.sixteen = Vector2(16, 16)
	vec.size.area = Vector2(vec.size.sixteen * 3)
	
	vec.size.token = Vector2(vec.size.sixteen * 1.5)
	
	init_window_size()


func init_window_size():
	vec.size.window = {}
	vec.size.window.width = ProjectSettings.get_setting("display/window/size/viewport_width")
	vec.size.window.height = ProjectSettings.get_setting("display/window/size/viewport_height")
	vec.size.window.center = Vector2(vec.size.window.width/2, vec.size.window.height/2)


func init_color():
	var h = 360.0
	
	color.defender = {}
	color.defender.active = Color.from_hsv(120 / h, 0.6, 0.7)


func save(path_: String, data_: String):
	var path = path_ + ".json"
	var file = FileAccess.open(path, FileAccess.WRITE)
	file.store_string(data_)


func load_data(path_: String):
	var file = FileAccess.open(path_, FileAccess.READ)
	var text = file.get_as_text()
	var json_object = JSON.new()
	var _parse_err = json_object.parse(text)
	return json_object.get_data()


func get_random_key(dict_: Dictionary):
	if dict_.keys().size() == 0:
		print("!bug! empty array in get_random_key func")
		return null
	
	var total = 0
	
	for key in dict_.keys():
		total += dict_[key]
	
	rng.randomize()
	var index_r = rng.randf_range(0, 1)
	var index = 0
	
	for key in dict_.keys():
		var weight = float(dict_[key])
		index += weight/total
		
		if index > index_r:
			return key
	
	print("!bug! index_r error in get_random_key func")
	return null
