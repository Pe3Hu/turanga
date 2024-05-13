extends MarginContainer


#region var
@onready var chapters = $Chapters

var god = null
#endregion


#region init
func set_attributes(input_: Dictionary) -> void:
	god = input_.god
	
	init_basic_setting()


func init_basic_setting() -> void:
	init_chapters()
	reorder_chapters()


func init_chapters() -> void:
	var kinds = ["col", "row"]
	var kind = kinds.pick_random()
	var n = god.foundation.rank + 2
	
	for _i in n:
		var bricks = []
		
		for _j in n:
			var index = null
			
			match kind:
				"row":
					index = _i * n + _j
				"col":
					index = _j * n + _i
			
			var brick = god.foundation.bricks.get_child(index)
			bricks.append(brick)
		
		add_chapter(bricks)


func add_chapter(bricks_: Array) -> void:
	var input = {}
	input.book = self
	input.bricks = bricks_
	
	var chapter = Global.scene.chapter.instantiate()
	chapters.add_child(chapter)
	chapter.set_attributes(input)


func reorder_chapters() -> void:
	var _chapters = []
	
	while chapters.get_child_count() > 0:
		var chapter = chapters.get_child(0)
		chapters.remove_child(chapter)
		_chapters.append(chapter)
	
	_chapters.shuffle()
	
	for chapter in _chapters:
		chapters.add_child(chapter)
#endregion
