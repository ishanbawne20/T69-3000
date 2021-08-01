extends KinematicBody2D

var State = "S"
export var omega = 0.5
export var speed = 100
export var causeDamage = 7
export var attackCooldown = 3
var cool
var maxHealth = 90
var health
var Player
var dir
var colli = null
onready var bar = get_node("ProgressBar")

export (PackedScene) var BloodSplash 

func _ready():
	cool = attackCooldown
	health = maxHealth
	bar.max_value = maxHealth
	Player = get_node("/root/World/Player")
	dir = Vector2(randi(), randi()).normalized()
	pass



func _physics_process(delta):
	cool-= delta
	detMove(delta)
	colli = move_and_collide(dir*speed*delta)
	if colli != null:
		if colli.get_collider().name == "Player" && cool <=0:
			Player.health -= causeDamage
			cool = attackCooldown
	pass
	
func _process(delta):
	bar.value = health
	if health <= 0:
		var blood = BloodSplash.instance()
		blood.position = position
		get_node("/root").add_child(blood)
		Player.score+= 1
		queue_free()

func detMove(delta):
	dir = position.direction_to(Player.position)
	look_at(Player.position)
	pass
