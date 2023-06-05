extends CanvasLayer

@onready var CoinsNode: Node = get_node("Control/CoinLabel")
@onready var HeartNode: Node = get_node("Control/HeartLabel")

func _ready() -> void:
	Globals.live_lost.connect(_updateHUD)
	_updateHUD()	

func _on_coin_collected() ->void:
	_updateHUD()

func _on_live_lost() ->void:
	_updateHUD()

func _updateHUD():
	print("updatehud")
	CoinsNode.text = str(Globals.coins)
	HeartNode.text = str(Globals.lives)
