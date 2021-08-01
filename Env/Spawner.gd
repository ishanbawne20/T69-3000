extends Node2D

export (PackedScene) var Enemy1
export (PackedScene) var Enemy2
export (PackedScene) var ChargeUp
export (PackedScene) var HealthCrate

var Player

export var waveCoolDown = 10
export var ChargeUpTres = 10
var isPow = false
var preScore = 0

var cool

func _ready():
	cool = -1
	Player = get_node("/root/World/Player")
	pass

func _process(delta):
	if cool <= 0:
		spawnRandom(delta)
		cool = waveCoolDown
		pass
	spawnPickUp(delta)
	cool -= delta
	pass

func spawnRandom(delta):
	for i in get_children():
		if retProb(0.8):
			pass
		else :
			continue

		if retProb(0.3):
			var en2 = Enemy2.instance()
			en2.position = i.position
			get_node("/root/World").add_child(en2)
		else:
			var en1 = Enemy1.instance()
			en1.position = i.position
			get_node("/root/World").add_child(en1)

func spawnPickUp(delta):
	if ((Player.score % ChargeUpTres == 0) and (Player.score != preScore)) and (not isPow) and retProb(0.3):
		var i = get_children()[randi()%self.get_child_count()]
		var powerup = ChargeUp.instance()
		powerup.position = i.position
		get_node("/root/World").add_child(powerup)
		preScore = Player.score
		isPow = true
	elif ((Player.score % ChargeUpTres == 0) and (Player.score != preScore)) and (not isPow) and retProb(0.5):
		var i = get_children()[randi()%self.get_child_count()]
		var powerup = HealthCrate.instance()
		powerup.position = i.position
		get_node("/root/World").add_child(powerup)
		preScore = Player.score
		isPow = true

func retProb(pro):
	if randf() <= pro:
		return true
	else:
		return false
