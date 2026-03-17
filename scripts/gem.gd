extends Area2D
@onready var audio: AudioStreamPlayer2D = $AudioStreamPlayer2D
signal collected

var gems := 1
var is_collected = false

func _on_body_entered(body: Node2D) -> void:
	if is_collected:
		return
	if body.is_in_group("Player"):
		is_collected = true
		audio.play() 
		hide() 
		set_deferred("monitoring", false) 
		await audio.finished
		collected.emit()
		GameState.gems += gems
		print(GameState.gems)
		queue_free() 
