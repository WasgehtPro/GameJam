extends RigidBody2D

var goal = Vector2(0, 0)
var strength = 0.1
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#apply_force((goal - global_position) * strength)
	pass
