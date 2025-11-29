extends CharacterBody2D
class_name Lander

@export var rotation_force: float
@export var thrust_force: float
@export var acceleration := 10.0
@export var air_friction: float = 0.5
@export var gravity := Vector2.DOWN * 4

@onready var thruster = %Thruster

var rotation_speed := 0.5
var thrust_speed := 25.0
var thurster_enabled := false:
	set(value):
		thurster_enabled = value
		if thurster_enabled:
			thruster.show()
		else:
			thruster.hide()

func _process(delta):
	if not is_multiplayer_authority():
		return
		
	rotation += rotation_force * rotation_speed * delta
	
	if thrust_force > 0:
		thurster_enabled = true
		var direction = Vector2.UP.rotated(rotation)
		var desired_velocity = direction * thrust_force * thrust_speed
		velocity = velocity.move_toward(desired_velocity, acceleration * delta)
	else:
		thurster_enabled = false
		velocity *= 1.0 - (air_friction * delta)
	
	move_and_slide()

func _physics_process(delta):
	if not is_multiplayer_authority():
		return
	velocity += gravity * delta
