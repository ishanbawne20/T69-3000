extends Area2D

export var speed = 500
export var damange = 10
var dir = Vector2.ZERO

func _ready():
	pass 


func _physics_process(delta):
	position+= dir*delta*speed
	
	for i in get_overlapping_bodies():
		if i.name == "Player" or i.name.find("Enemy") != -1:
			i.health -= damange
			queue_free()
	pass

func start(dire):
	dir = dire


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
