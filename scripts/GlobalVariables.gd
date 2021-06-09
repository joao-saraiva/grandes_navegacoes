extends Node

var coins = 0

func _ready():
	coins = SaveFile.loadData.coins
