extends KinematicBody2D

export var speed = 12000
export var MaxDisc = 2
export var maxHealth = 100
var vel = Vector2(0,0)
var curDisc = null



export (PackedScene) var Disc
export (PackedScene) var BloodSplash

var score = 0
var health
var afteded = 3


func _ready():
	curDisc = MaxDisc
	health = maxHealth
	pass 


func _physics_process(delta):
	if health <= 0:
		speed = 0
		var blood = BloodSplash.instance()
		blood.position = position
		get_node("/root").add_child(blood)
		afteded-= delta
		if afteded <= 0:
			get_tree().change_scene("res://MainMenu.tscn")
	alignrock()
	vel = vel.linear_interpolate(movement(),0.1)
	move_and_slide(vel*speed*delta,Vector2(0,0))
	if curDisc < 0:
			curDisc = 0
	pass
	
func movement():
	var velocity = Vector2(0,0)
	if Input.is_action_pressed("ui_up"):
		velocity += Vector2(0,-1)
	if Input.is_action_pressed("ui_down"):
		velocity += Vector2(0,1)
	if Input.is_action_pressed("ui_left"):
		velocity += Vector2(-1,0)
	if Input.is_action_pressed("ui_right"):
		velocity += Vector2(1,0)
	if Input.is_action_just_pressed("shoot") and curDisc > 0:
		shoot()
		curDisc -=1
		pass
	return velocity.normalized()
	pass
	
func alignrock():
	self.look_at(get_global_mouse_position())
	pass

func shoot():
	var disc = Disc.instance()
	get_parent().add_child(disc)
	disc.start(get_node("Muzzle").global_position, self)
	pass
