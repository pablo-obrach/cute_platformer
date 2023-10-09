extends Node


signal collected_feather(int)

var feather: int
var player: Player



func gain_feather(feather_gained:int):
	feather += feather_gained
	emit_signal("collected_feather",feather_gained)
	print(feather)


