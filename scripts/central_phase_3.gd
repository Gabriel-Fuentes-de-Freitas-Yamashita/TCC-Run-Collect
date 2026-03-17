extends Node2D

@onready var player: CharacterBody2D = $Player
@onready var _003_plate: AnimatedSprite2D = $fase_003_plate
var door_id: String = "phase_3"

@onready var gems_container: HBoxContainer = $LABELS/Labels/container/gems_container


@export var unlock_door: String = ""




func _ready() -> void:
	gems_container.hide()
	GameState.active_timer = false
	GameState.unlock_door(unlock_door)
	_003_plate.play("transition")
