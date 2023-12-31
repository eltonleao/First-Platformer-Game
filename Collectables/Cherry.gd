extends Area2D
signal cherry_collected

@onready var hero = get_node("../../Player/Player")

func _ready():
	get_node("AnimatedSprite2D").play("idle")
	

func _on_body_entered(body):
	if body.name == 'Player':
		Game.Gold += 5;
		hero.SPEED += 100;
		hero.JUMP_VELOCITY -= 100;
		var tween = get_tree().create_tween()
		tween.tween_property(self, "position", position - Vector2(0, 25), 0.5)
		tween.tween_property(self, "modulate:a", 0, 0.5)
		emit_signal("cherry_collected")
		tween.tween_callback(queue_free)
