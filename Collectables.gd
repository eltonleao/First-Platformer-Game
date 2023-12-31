extends Node2D


var Cherry = preload("res://Collectables/Cherry.tscn")

var teste = 0;

func _on_timer_timeout():
	var CherryTemp = Cherry.instantiate();
	var rand = RandomNumberGenerator.new();
	var randint = rand.randi_range(10, 400);
	CherryTemp.position = Vector2(randi_range(10, 999), randi_range(10,999))
	
	add_child(CherryTemp);
