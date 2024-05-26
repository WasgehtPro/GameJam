extends Node2D

@onready var pipe = $"."
const PIPE = preload("res://Items/Pipe/pipe.tscn")
@export var player: CharacterBody2D
@onready var sprite = $Sprite
var equipped = false
@onready var collision = $Collision

func _on_area_2d_body_entered(body):
	body.free()

#func Use():
	#create_tween().tween_property(pipe, "rotation", 90, 0.2)
	#create_tween().tween_property(pipe, "rotation", 0, 1)
	
func onEquip():
	collision.disabled = true
	sprite.play("highlighted")

func pickUp():
	queue_free()
	return PIPE.instantiate()

func _on_highlight_range_mouse_entered():
	if not equipped:
		sprite.play("highlighted")

func _on_highlight_range_mouse_exited():
	if not equipped:
		sprite.play("default")
