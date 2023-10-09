extends CanvasLayer

@onready var featherSFX: AudioStreamPlayer = $coinSFX

func _ready():
	GameManagement.collected_feather.connect(update_father_display)

func update_father_display(_collected_feather):
	featherSFX.play()
	$FeatherDisplay.text = str(GameManagement.feather)
