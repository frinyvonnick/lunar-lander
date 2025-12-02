extends Node2D

@onready var player: Player = %Player
@onready var lander: Lander = %Lander
@onready var stats_label: Label = %Stats
@onready var landing: LandingPad = %LandingPad

@onready var victory_menu: Menu = %VictoryMenu
@onready var loose_menu: Menu = %LooseMenu

func _ready():
	lander.started = true
	lander.crashed.connect(func():
		get_tree().paused = true
		loose_menu.show = true
	)
	lander.landed.connect(func():
		get_tree().paused = true
		victory_menu.show = true
	)

func _process(delta):
	lander.rotation_force = player.rotation_force
	lander.thrust_force = player.thrust_force

	update_debug_ui()
	
func update_debug_ui():
	var debug_info = {
		"Vitesse Y": "%.1f" % lander.velocity.y,
		"Vitesse X": "%.1f" % lander.velocity.x,
		"Angle": "%.1f°" % rad_to_deg(lander.rotation),
	}

	var lines = []
	for key in debug_info:
		lines.append("%s: %s" % [key, debug_info[key]])

	stats_label.text = "\n".join(lines)
