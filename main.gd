extends Node2D


func _ready():
	#Utils.saveGame()
	if(Game.playerHP <= 0):
		Game.playerHP = 10;
		Utils.saveGame();
		Game.GameOver = false;
	Utils.loadGame()


func _on_quit_pressed():
	Game.Gold = 0
	Game.Frogs = 0;
	Game.FrogVelocity = 100
	Utils.saveGame()


func _on_play_pressed():
	get_tree().change_scene_to_file("res://world.tscn");
