extends Node2D

@onready var lander: Lander = %Lander
@onready var stats_label: Label = %Stats

var players: Array[Player]:
	get:
		var result: Array[Player]
		result.assign(get_children().filter(func(node: Node):
			return node is Player
		))
		return result

func _process(delta):
	for player in players:
		if player.thrust_enabled:
			lander.thrust_force = player.thrust_force
		if player.rotation_enabled:
			lander.rotation_force = player.rotation_force
	
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
