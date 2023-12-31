extends CharacterBody2D
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var player
var chase
var speed = Game.FrogVelocity
var direction = 0;
var jump_speed = -500 # Negative because we want to go upwards
@onready var frog = get_node("AnimatedSprite2D")
@onready var hero = get_node("../Player/Player")


func _ready():
	frog.play('idle')

func _physics_process(delta):

	if chase:
		if frog.animation != 'death':
			frog.play('jump')
		player = get_node("../../Player/Player")
		var direction = (player.position - self.position).normalized();
		if direction.x > 0:
			get_node("AnimatedSprite2D").flip_h = true
			velocity.x = direction.x * speed
		else: 
			get_node("AnimatedSprite2D").flip_h = false
			velocity.x = direction.x * speed
			
		velocity.y += gravity * delta
	else:
		if frog.animation != 'death':
			frog.play('idle')
		velocity.x = 0;
	move_and_slide()

func _on_player_detection_body_entered(body):
	if body.name == 'Player':
		chase = true
		

func _on_player_detection_body_exited(body):
	if body.name == 'Player':
		chase = false


func _on_player_death_body_entered(body):
	if body.name == 'Player':
		death();


func _on_player_collision_body_entered(body):
	if body.name == 'Player':
		Game.playerHP -= 3
		death()

func death():
	  

	Game.Gold += 5;
	Game.Frogs += 1;
	Utils.saveGame();
	chase = false
	get_node("AnimatedSprite2D").play('death')
	await get_node("AnimatedSprite2D").animation_finished;
	self.queue_free();



func _on_timer_timeout():
	if is_on_floor() and chase:
		# Apply an upward force
		velocity.y = -300 # Negative because we want to go upwards
