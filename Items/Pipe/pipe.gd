extends RigidBody2D

var iManager = preload("res://ModuleScripts/ItemManager.gd").new()
const bluePrint = preload("res://Items/Pipe/pipe.tscn")

@onready var throwTimer = $ThrowTimer
@onready var hitBox = $HitBox/MainCollision

@onready var sprite = $Sprite

@export var damage = 20
var equipped = false
var flying = false

func use():
	hitBox.disabled = false
	var swing1 = create_tween()
	swing1.tween_property(self, "rotation", deg_to_rad(90), .05)
	await swing1.finished
	var swing2 = create_tween()
	swing2.tween_property(self, "rotation", deg_to_rad(0), .5)
	await swing2.finished
	hitBox.disabled = true

func onThrowStart():
	hitBox.disabled = false

func onThrowStop():
	flying = true
	throwTimer.start()
	
func _on_throw_timer_timeout():
	if linear_velocity.length() < 30:
		hitBox.disabled = true
		flying = false
		throwTimer.stop()
	
func drop(transform, dir):
	iManager.drop(self, bluePrint, transform, dir)
	
func onEquip():
	$Collision.disabled = true
	sprite.play("highlighted")
	equipped = true

func pickUp():
	return iManager.pickUp(self, bluePrint)

func _on_highlight_range_mouse_entered():
	if not equipped:
		iManager.highlight(sprite, equipped)

func _on_highlight_range_mouse_exited():
	if not equipped:
		iManager.unHighlight(sprite, equipped)

func _on_area_2d_body_entered(body):
	if body.is_in_group("Enemy"):
		body.hit(damage)

func _on_highlight_range_body_entered(body):
	if body.is_in_group("Enemy") and flying:
		body.hit(damage)
