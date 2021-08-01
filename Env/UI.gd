extends Control


var healthbar
var score
var Player


func _ready():
	healthbar = get_node("Health")
	score = get_node("Score")
	Player = get_node("/root/World/Player")
	
	healthbar.max_value = Player.maxHealth
	healthbar.value = Player.health
	score.text = "Score: 0" 
	pass


func _process(delta):
	healthbar.value = Player.health
	score.text ="Score : "+String(Player.score)
	pass
