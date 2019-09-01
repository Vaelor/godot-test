extends KinematicBody2D

const MOTION_SPEED = 160
var rotatedBy: int = 0

func _physics_process(_delta):
	var motion = Vector2()
	
	if Input.is_action_pressed("move_up"):
		$Sprite.flip_v = false
		motion += Vector2(0, -1)
	if Input.is_action_pressed("move_bottom"):
		$Sprite.flip_v = true
		motion += Vector2(0, 1)
	if Input.is_action_pressed("move_left"):
		motion += Vector2(-1, 0)
	if Input.is_action_pressed("move_right"):
		motion += Vector2(1, 0)
	
	motion = motion.normalized() * MOTION_SPEED
	move_and_slide(motion)
