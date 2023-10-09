extends CanvasLayer

@onready var featherSFX: AudioStreamPlayer = $coinSFX


func _ready():
	GameManagement.collected_feather.connect(update_father_display)
	GameManagement.pause_menu = $PauseMenu
	GameManagement.score_update.connect(update_score_display)

func _process(_delta):
	if Input.is_action_just_pressed("pause"):
		GameManagement.pause_play()

func update_father_display(_collected_feather):
	featherSFX.play()
	$FeatherDisplay.text = str(GameManagement.feather)


func update_score_display(_score_gained):
	$Score.text = "Score: " + str(GameManagement.score)




func _on_resume_pressed():
	GameManagement.resume()


func _on_restart_pressed():
	GameManagement.restart()


func _on_main_menu_pressed():
	pass # Replace with function body.


func _on_quit_pressed():
	GameManagement.quit()
