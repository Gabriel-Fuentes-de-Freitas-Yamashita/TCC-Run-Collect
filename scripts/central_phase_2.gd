extends Node2D

@onready var player: CharacterBody2D = $Player
@onready var _002_plate: AnimatedSprite2D = $fase_002_plate
var door_id: String = "phase_2"

@onready var gems_container: HBoxContainer = $LABELS/Labels/container/gems_container



@export var unlock_door: String = ""




func _ready() -> void:
	gems_container.hide()
	GameState.active_timer = false
	GameState.unlock_door(unlock_door)
	_002_plate.play("transition")
