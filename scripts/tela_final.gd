extends Control

# Variáveis de tempo da animação
@export var letter_time = 0.08
@export var punctuation_time = 0.2
@export var space_time = 0.1

# Ajuste os nós conforme a sua cena
@onready var time_label: Label = $VBoxContainer/HBoxContainer/Time
@onready var nome_label: Label = $VBoxContainer/HBoxContainer/Nome
@onready var score_label: Label = $VBoxContainer/HBoxContainer/Score


# Variáveis de controle
var wait_tween: Tween
var skipped = false
var animation_finished = false # Nova variável para saber quando podemos mudar de tela

var orig_letter_time
var orig_punctuation_time
var orig_space_time

func _ready():
	orig_letter_time = letter_time
	orig_punctuation_time = punctuation_time
	orig_space_time = space_time
	
	# 1. Calcula e monta os textos nas três colunas
	montar_placar()
	
	# 2. Deixa as colunas invisíveis para o efeito começar
	nome_label.visible_ratio = 0.0
	score_label.visible_ratio = 0.0
	time_label.visible_ratio = 0.0
	
	# 3. Começa a digitar
	write_sentence()

func calculo_score() -> int:
	var bonus_maximo = 9000
	var time_points = max(0, bonus_maximo - (int(GameState.total_time) * 20))
	var moedas_points = GameState.coins * 50
	var score_final = time_points + moedas_points
	return score_final

func montar_placar():
	var meu_score = calculo_score()
	var meu_tempo = GameState.get_time()

	var leaderboard = [
		{"nome": "M4TH", "score": "08580", "tempo": "02:31:13"},
		{"nome": "FUFU", "score": "08250", "tempo": "02:40:87"},
		{"nome": "AK1R", "score": "08410", "tempo": "02:37:54"},
		{"nome": "VOCÊ", "score": str(meu_score).pad_zeros(5), "tempo": meu_tempo}
	]
	
	# Ordena do maior pro menor
	leaderboard.sort_custom(func(a, b): return int(a["score"]) > int(b["score"]))
	
	var texto_nomes = "NOME\n\n"
	var texto_scores = "PONTOS\n\n"
	var texto_tempos = "TEMPO\n\n"
	
	for i in range(leaderboard.size()):
		var jogador = leaderboard[i]
		var posicao = str(i + 1) + ". "
		
		texto_nomes += posicao + jogador["nome"] + "\n"
		texto_scores += str(jogador["score"]) + "\n"
		texto_tempos += jogador["tempo"] + "\n"
		
	nome_label.text = texto_nomes
	score_label.text = texto_scores
	time_label.text = texto_tempos

func write_sentence():
	
	var total_nomes = nome_label.get_total_character_count()
	var total_scores = score_label.get_total_character_count()
	var total_tempos = time_label.get_total_character_count()
	
	# Pega o número máximo de letras entre as três colunas para o loop
	var max_chars = max(total_nomes, max(total_scores, total_tempos))
	var current_char_index = 0
	
	while current_char_index < max_chars:
		# Adiciona 1 caractere em cada coluna simultaneamente
		if nome_label.visible_characters < total_nomes:
			nome_label.visible_characters += 1
		if score_label.visible_characters < total_scores:
			score_label.visible_characters += 1
		if time_label.visible_characters < total_tempos:
			time_label.visible_characters += 1
			
		current_char_index += 1
		
		# Pega o caractere atual da coluna Nomes para definir a pausa
		var current_time = letter_time
		if nome_label.visible_characters > 0 and nome_label.visible_characters <= total_nomes:
			var current_character = nome_label.text[nome_label.visible_characters - 1]
			match current_character:
				" ": current_time = space_time
				".", "!", "?", "\n": current_time = punctuation_time
		
		wait_tween = create_tween()
		wait_tween.tween_interval(current_time)
		await wait_tween.finished
		
	
	# Marca que terminou de escrever, liberando a troca de cena
	animation_finished = true 

func _input(event):
	if event.is_action_pressed("interact"):
		
		# Se a animação está rolando e ele apertou "E", acelera tudo (Skip)
		if not animation_finished and not skipped:
			skipped = true
			letter_time = 0.0
			punctuation_time = 0.0
			space_time = 0.0
			
			if wait_tween and wait_tween.is_valid():
				wait_tween.set_speed_scale(1000.0)
				
		# Se a animação JÁ TERMINOU e ele apertou "E", vai para os Créditos
		elif animation_finished:
			get_tree().change_scene_to_file("res://scenes/credits.tscn")
