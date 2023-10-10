extends Node

signal collected_feather(int)
signal score_update(int)


var feather: int
var score: int = 0
var player: Player
var pause_menu

var score_label

var paused = false

	
func gain_score(score_gained:int):
	score += score_gained
	emit_signal("score_update",score_gained)
	

func gain_feather(feather_gained:int):
	feather += feather_gained
	emit_signal("collected_feather",feather_gained)

func pause_play():
	paused = !paused
	
	if paused:
		get_tree().paused = true
		pause_menu.visible = paused

	else:
		get_tree().paused = false
		pause_menu.visible = paused

func resume():
	pause_play()

func restart():
	feather = 0
	score = 0
	get_tree().reload_current_scene()
	get_tree().paused = false

func main_menu():
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")

func quit():
	get_tree().quit()
