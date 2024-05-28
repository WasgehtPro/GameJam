extends CharacterBody2D

@export var player: Node2D
@onready var navAgent = $NavigationAgent2D
@onready var timer = $Timer
@onready var arms = $Arms
@onready var progress_bar = $Control/ProgressBar

var speed = 20
var pushForce = 200
var health = 100

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var dir = to_local(navAgent.get_next_path_position()).normalized()
	velocity = dir * speed
	
	arms.rotate(lerp_angle(deg_to_rad(arms.rotation), deg_to_rad(arms.get_angle_to(player.global_position)), 1))
	
	if move_and_slide():
		var col = get_last_slide_collision()
		var obj = col.get_collider()
		if obj is RigidBody2D:
			obj.apply_force(col.get_normal() * -pushForce / obj.mass)

func _on_timer_timeout():
	navAgent.target_position = player.global_position

func hit(damage):
	health -= damage
	progress_bar.value = health
	if progress_bar.value < 1:
		queue_free()
