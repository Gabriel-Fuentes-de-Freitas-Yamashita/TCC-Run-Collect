extends Control

@onready var coins_counter: Label = $container/coins_container/coins_counter
@onready var timer_counter: Label = $container/timer_container/timer_counter
@onready var gems_counter: Label = $container/gems_container/gems_counter



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameState.gems = 0
	coins_counter.text = str("%03d" % GameState.coins)
	gems_counter.text = str("%03d" % GameState.gems) 
	timer_counter.text = GameState.get_time()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	coins_counter.text = str("%03d" % GameState.coins)
	gems_counter.text = str(GameState.gems) + "/3"
	timer_counter.text = GameState.get_time()
