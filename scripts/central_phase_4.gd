extends Node2D

@onready var player: CharacterBody2D = $Player
@onready var _004_plate: AnimatedSprite2D = $fase_004_plate
var door_id: String = "phase_4"

@onready var gems_container: HBoxContainer = $LABELS/Labels/container/gems_container


@export var unlock_door: String = ""




func _ready() -> void:
	gems_container.hide()
	GameState.active_timer = false
	GameState.unlock_door(unlock_door)
	_004_plate.play("transition")
