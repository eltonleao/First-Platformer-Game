extends Node


const SAVE_PATH = 'res://savegame.bin'

func saveGame():
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	var data: Dictionary = {
		"playerHP": Game.playerHP,
		"Gold": Game.Gold,
		"Frogs:" : Game.Frogs,
		"FrogVelocity": Game.FrogVelocity
	}
	var jstr = JSON.stringify(data);
	file.store_line(jstr)
	
	
func loadGame():
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)

	if FileAccess.file_exists(SAVE_PATH):
		if not file.eof_reached():
			var current_line = JSON.parse_string(file.get_line())

			if current_line:
				# Check if "playerHP" key exists
				if "playerHP" in current_line:
					Game.playerHP = current_line["playerHP"]

				# Check if "Gold" key exists
				if "Gold" in current_line:
					Game.Gold = current_line["Gold"]

				# Check if "Frogs" key exists
				if "Frogs" in current_line:
					Game.Frogs = current_line["Frogs"]
					
				if "FrogVelocity" in current_line:
					Game.FrogVelocity = current_line["FrogVelocity"]










