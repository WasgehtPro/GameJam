extends Node2D

const PIPE = preload("res://Items/Pipe/pipe.tscn")
@export var player: CharacterBody2D
@onready var sprite = $Sprite
var equipped = false
@onready var collision = $Collision
@onready var pipe = $"."

func Use():
	var swing1 = create_tween()
	swing1.tween_property(self, "rotation", deg_to_rad(90), .05)
	await  swing1.finished
	var swing2 = create_tween()
	swing2.tween_property(self, "rotation", deg_to_rad(0), .5)
	
func drop(transform, dir):
	queue_free()
	var item := PIPE.instantiate() as RigidBody2D
	item.global_transform = transform
	item.apply_force(dir * 2000)
	get_tree().get_current_scene().add_child(item)
	
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


func _on_area_2d_body_entered(body):
	if body.is_in_group("Enemy"):
		body.hit(20)
