extends Node2D

@onready var player: CharacterBody2D = $Player
@onready var _001_plate: AnimatedSprite2D = $fase_001_plate
var door_id: String = "phase_1"

@onready var gems_container: HBoxContainer = $LABELS/Labels/container/gems_container




@export var unlock_door: String = ""




func _ready() -> void:
	GameState.coins = 0
	gems_container.hide()
	GameState.active_timer = false
	GameState.has_double_jump = false
	GameState.has_wall_jump = false
	player.has_wall_jump = false
	player.max_jump_count = 1
	GameState.unlock_door(unlock_door)
	_001_plate.play("transition")
