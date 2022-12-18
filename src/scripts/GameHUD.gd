extends CanvasLayer




onready var CoinsNode = get_node("Control/CoinLabel")

func _ready():
	CoinsNode.text = "0"


func _on_coin_collected():
	CoinsNode.text = String(Globals.coins)
