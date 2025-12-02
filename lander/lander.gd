extends CharacterBody2D
class_name Lander

@export var rotation_force: float
@export var thrust_force: float
@export var acceleration := 10.0
@export var air_friction: float = 0.5
@export var gravity := Vector2.DOWN * 4
@export var landing_angle_tolerance := 5.0
@export var landing_speed_tolerance := 5.0

@onready var thruster = %Thruster

var has_landed := false
var rotation_speed := 0.5
var thrust_speed := 25.0
var thurster_enabled := false:
	set(value):
		thurster_enabled = value
		if thurster_enabled:
			thruster.show()
		else:
			thruster.hide()
# Vélocité avant collision (pour calculer la vitesse d'impact)
var velocity_before_collision := Vector2.ZERO
var impact_speed: float:
	get:
		var floor_normal = get_floor_normal()
		return abs(velocity_before_collision.dot(floor_normal))
var started := false

signal landed
signal crashed

func _check_angle_conditions():
	var floor_normal = get_floor_normal()
	var lander_up = Vector2.UP.rotated(rotation)
	var angle_diff = abs(rad_to_deg(lander_up.angle_to(floor_normal)))
	return angle_diff <= landing_angle_tolerance

func _check_speed_conditions():
	return impact_speed < landing_speed_tolerance

func _check_landed_conditions():
	if not is_on_floor():
		_crash()
		return

	if _check_angle_conditions() and _check_speed_conditions():
		_land()
	else:
		_crash()


func _crash():
	crashed.emit()

func _land():
	landed.emit()

func _process(delta):
	if not is_multiplayer_authority() or not started:
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

	# Sauvegarder la vélocité AVANT move_and_slide pour calculer la vitesse d'impact
	velocity_before_collision = velocity

	move_and_slide()

	if get_slide_collision_count() > 0 and not has_landed:
		has_landed = true
		_check_landed_conditions()

func _physics_process(delta):
	if not is_multiplayer_authority() or not started:
		return
	velocity += gravity * delta
