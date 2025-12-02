extends Node2D
class_name GameManager

@onready var lander: Lander = %Lander
@onready var stats_label: Label = %Stats

var started := false:
	set(value):
		if started == true and value == false:
			_reset.rpc()
		if started == false and value == true:
			lander.started = true
		started = value

# Ces nodes sont optionnels (pas disponibles en mode headless)
var victory_menu: Menu
var loose_menu: Menu
var victory_main_menu_button: Button
var loose_main_menu_button: Button
var online_multiplayer_screen: OnlineMultiplayerScreen

var players: Array[Player]:
	get:
		var result: Array[Player]
		result.assign(get_children().filter(func(node: Node):
			return node is Player
		))
		return result

func _back_to_main_menu():
	if not online_multiplayer_screen:
		return
	# TODO: Let parent decide what to do through a signal
	multiplayer.multiplayer_peer.close()
	online_multiplayer_screen.show()

@rpc("any_peer", "call_local")
func _reset():
	if not lander or not victory_menu or not loose_menu:
		return

	get_tree().paused = false
	victory_menu.show = false
	loose_menu.show = false
	var viewport_width = ProjectSettings.get_setting("display/window/size/viewport_width")
	var viewport_height = ProjectSettings.get_setting("display/window/size/viewport_height")
	lander.started = false
	lander.position = Vector2(viewport_width / 2, viewport_height / 2)

func _ready():
	# Récupérer les nodes optionnels (peuvent être null en mode headless)
	victory_menu = get_node_or_null("%VictoryMenu")
	loose_menu = get_node_or_null("%LooseMenu")
	victory_main_menu_button = get_node_or_null("%VictoryMainMenuButton")
	loose_main_menu_button = get_node_or_null("%LooseMainMenuButton")
	online_multiplayer_screen = get_node_or_null("%OnlineMultiplayerScreen")

	# Si les nodes ne sont pas disponibles, ne pas initialiser (mode headless/lobby)
	if not victory_main_menu_button or not loose_main_menu_button:
		return
	if not lander or not victory_menu or not loose_menu:
		return

	victory_main_menu_button.pressed.connect(_back_to_main_menu)
	loose_main_menu_button.pressed.connect(_back_to_main_menu)
	lander.crashed.connect(func():
		get_tree().paused = true
		loose_menu.show = true
	)
	lander.landed.connect(func():
		get_tree().paused = true
		victory_menu.show = true
	)

func _process(delta):
	if not started:
		return

	for player in players:
		if player.thrust_enabled:
			lander.thrust_force = player.thrust_force
		if player.rotation_enabled:
			lander.rotation_force = player.rotation_force

	update_debug_ui()

func update_debug_ui():
	if not lander or not stats_label:
		return

	var debug_info = {
		"Manager started": str(started),
		"Lander started": str(lander.started),
		"Vitesse Y": "%.1f" % lander.velocity.y,
		"Vitesse X": "%.1f" % lander.velocity.x,
		"Angle": "%.1f°" % rad_to_deg(lander.rotation),
	}

	var lines = []
	for key in debug_info:
		lines.append("%s: %s" % [key, debug_info[key]])

	stats_label.text = "\n".join(lines)
