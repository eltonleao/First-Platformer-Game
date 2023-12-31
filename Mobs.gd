extends Node2D

var Frog = preload("res://frog.tscn")

func _on_timer_timeout():
	var temp = Frog.instantiate();
	var rand = RandomNumberGenerator.new();
	var randint = rand.randi_range(10, 2000);
	temp.position = Vector2(randint, 0)
	
	add_child(temp);
