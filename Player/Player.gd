extends CharacterBody2D

var SPEED = 300.0
var JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var anim = get_node("AnimatedSprite2D");

func _ready():	 
	anim.play("idle")
	print(get_node("res://Collectables/Cherry.gd"))


func _on_cherry_collected():
	SPEED *= 2 # double the speed

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		anim.play('jump')
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction == -1 :
		get_node("AnimatedSprite2D").flip_h = true
	elif direction == 1:
		get_node("AnimatedSprite2D").flip_h = false
	
	if direction:
		velocity.x = direction * SPEED
		if !velocity.y:
			anim.play("run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if !velocity.y:
			anim.play('idle')
	if velocity.y > 0:
		anim.play('fall')

	move_and_slide()
	
	if Game.playerHP <= 0:
		anim.play('death')
		self.queue_free();
		Game.FrogVelocity = Game.FrogVelocity + 100;
		Utils.saveGame();
		get_tree().change_scene_to_file('res://main.tscn')
