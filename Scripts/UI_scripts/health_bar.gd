extends Control

@onready var fill_max = $ColorRect.size.x

var fill_amount : float

func update_health_bar(health, max_health):
	fill_amount = (float(health) / max_health) * fill_max
	$ColorRect.size.x = fill_amount

	if fill_amount == 0:
		await get_tree().create_timer(1).timeout
		$ColorRect.size.x = 24
