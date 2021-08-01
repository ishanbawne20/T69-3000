extends KinematicBody2D

export var omega = 0.5
export var speed = 100
export var shotRange = 400
export var shotCooldown = 5
var cool
var maxHealth = 60
var health
var Player
var dir
onready var bar = get_node("ProgressBar")

export (PackedScene) var BloodSplash
export (PackedScene) var Bullet

func _ready():
	cool = shotCooldown
	health = maxHealth
	bar.max_value = maxHealth
	Player = get_node("/root/World/Player")
	dir = Vector2(randi(), randi()).normalized()
	pass



func _physics_process(delta):
	detMove(delta)
	move_and_slide(dir*speed,Vector2(0,0))
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
	cool-= delta
	if self.position.distance_to(Player.position) > shotRange:
		dir = position.direction_to(Player.position)
		
	elif cool <= 0:
		dir = Vector2.ZERO
		var bullet = Bullet.instance()
		bullet.start(position.direction_to(Player.position))
		bullet.position = get_node("Muzzle").global_position
		bullet.rotation = global_rotation
		get_node("/root").add_child(bullet)
		cool = shotCooldown
	else:
		dir = Vector2.ZERO
	look_at(Player.position)
	pass
	
func shoot(delta):
	pass
