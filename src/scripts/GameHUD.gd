extends CanvasLayer

onready var CoinsNode: Node = get_node("Control/CoinLabel")

func _ready() -> void:
	CoinsNode.text = String(Globals.coins)


func _on_coin_collected() ->void:
	_ready()
