extends Node

var score = 0

var main
var dead = false

var save_dict = {
	"max_score": 0,
	"money": 20,
	"curr_plane": 0,
	"curr_trail": 0,
	"planes": [true, false, false, false],
	"trails": [true, false, false, false],
}

func _ready():
	_load()

func save():
	var file = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	file.store_var(save_dict)
	file.close()

func _load():
	if FileAccess.file_exists("user://savegame.save"):
		var file = FileAccess.open("user://savegame.save", FileAccess.READ)
		save_dict = file.get_var()
		file.close()

func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		save()
		get_tree().quit()
