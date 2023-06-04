extends CanvasLayer

@onready var CoinsNode: Node = get_node("Control/CoinLabel")
@onready var HeartNode: Node = get_node("Control/HeartLabel")

func _ready() -> void:
	CoinsNode.text = str(Globals.coins)
	HeartNode.text = str(Globals.lives)


func _on_coin_collected() ->void:
	_ready()

func _on_live_lost() ->void:
	_ready()
