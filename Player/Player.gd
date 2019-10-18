extends KinematicBody2D

const GRAVITY = 2000
const MAXFALLSPEED = 1000
const MOVESPEED = 400
const JUMPSPEED = 1300

var velocity = Vector2(0, 0)

func _physics_process(delta):
	velocity.y += GRAVITY * delta
		
	get_node("AnimatedSprite").flip_h = velocity.x < 0
	
	velocity.y = min(velocity.y, MAXFALLSPEED)
	
	if Input.is_action_pressed("ui_left"):
		velocity.x = -MOVESPEED
	
	elif Input.is_action_pressed("ui_right"):
		velocity.x = MOVESPEED
		
	else:
		velocity.x = 0
		
	move_and_slide(velocity, Vector2.UP)
	
	if is_on_floor():
		velocity.y = 0
		
		if Input.is_action_pressed("ui_up"):
			velocity.y = -JUMPSPEED
	
	if not is_on_floor():
		get_node("AnimatedSprite").play("jump")
	elif velocity.x != 0:
		get_node("AnimatedSprite").play("walk")
	else:
		get_node("AnimatedSprite").play("default")
	