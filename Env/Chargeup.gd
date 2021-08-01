extends Area2D

export var Discs = 1
export var lifetime = 15


func _ready():
	pass 


func _process(delta):
	if lifetime <= 0:
		queue_free()
	for i in get_overlapping_bodies():
		if i.name == "Player":
			i.curDisc += Discs
			get_node("/root/World/Spawner").isPow = false
			queue_free()
	
	lifetime -= delta
	pass
