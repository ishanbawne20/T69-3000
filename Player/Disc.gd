extends Area2D


export var disc_vel = 1000
export var threshold = 300
export var damage = 30
var dir = Vector2(0,0)
var Player = null


func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	returninig(delta)
	for i in get_overlapping_bodies():
		if i.name == "Player":
			Player.curDisc+= 1
			queue_free()
	pass

func start(position, player):
	self.position = position
	Player = player
	dir = (get_global_mouse_position() - self.position).normalized()
	self.look_at(get_global_mouse_position())
	
	
func returninig(delta):
	if((Player.position- position).length() > threshold):
		dir = lerp(dir, position.direction_to(Player.position),0.9)
	else:
		pass
	
	self.position+= dir.normalized()*disc_vel*delta


func _on_Disc_body_entered(body):
	if body.name.find("Enemy") != -1:
		body.health-= damage
	pass # Replace with function body.
