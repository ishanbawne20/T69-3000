extends Area2D

export var health = 20
export var lifetime = 15


func _ready():
	pass 


func _process(delta):
	if lifetime <= 0:
		queue_free()
	for i in get_overlapping_bodies():
		if i.name == "Player":
			if i.health+health >= i.maxHealth:
				i.health = i.maxHealth
			else:
				i.health+= health
			get_node("/root/World/Spawner").isPow = false
			queue_free()
	
	lifetime -= delta
	pass
