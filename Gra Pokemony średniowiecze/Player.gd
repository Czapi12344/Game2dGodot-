extends CharacterBody2D

@export var MAX_SPEED = 300
@export var ACCE = 1500
@export var FRICTION = 1200

@onready var axis = Vector2.ZERO


func _physics_process(delta):
	move(delta)
	
	
func getInputAxis():
	axis.x = int( Input.is_action_pressed("moveRight"))  - int( Input.is_action_pressed("moveLeft")) 
	
	axis.y = int( Input.is_action_pressed("moveDown"))  - int( Input.is_action_pressed("moveUp")) 
	
	return axis
	
func move(delta):
	axis = getInputAxis()
	
	if axis == Vector2.ZERO:
		
		applyFriction( FRICTION * delta)
		
	else:
		applyMovement( axis * ACCE * delta )
		
	move_and_slide()


func applyFriction( value):
	
	if( velocity.length() > value):
		velocity -= velocity.normalized() * value
	
	else:
		velocity = Vector2.ZERO
		
func applyMovement( acc):
	
	velocity += acc
	
	velocity = velocity.limit_length( MAX_SPEED )
	
