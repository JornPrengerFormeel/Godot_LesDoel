extends RigidBody2D

export var player_speed = 200
export var jumpforce = 1000
export var acceleration = 5
export var extra_grav = 5

var raycast_down = null

var current_speed = Vector2(0, 0)

var btn_right = Input.is_action_pressed("btn_right")
var btn_left = Input.is_action_pressed("btn_left")
var btn_jump = Input.is_action_pressed("btn_jump")

func move(speed, acc, delta):
	current_speed.x = lerp(current_speed.x, speed, acc * delta)
	set_linear_velocity(Vector2(current_speed.x,get_linear_velocity().y))

func is_on_ground():
	if raycast_down.is_colliding():
		return true 
	else:
		return false

func _ready():
	raycast_down = get_node("RayCast2D")
	raycast_down.add_exception(self)
	
	# Initalization here
	set_fixed_process(true)
	set_applied_force(Vector2(0, extra_grav))
	
func _fixed_process(delta):
	btn_right = Input.is_action_pressed("btn_right")
	btn_left = Input.is_action_pressed("btn_left")
	btn_jump = Input.is_action_pressed("btn_jump")
	
	is_on_ground()
	
	if btn_left:
		move(-player_speed, acceleration, delta)
		#set_linear_velocity(Vector2(-player_speed,get_linear_velocity().y))
	elif btn_right:
		move(player_speed, acceleration, delta)
		#set_linear_velocity(Vector2(player_speed,get_linear_velocity().y))
	else:
		move(0, acceleration, delta)
		
	if is_on_ground():
		if btn_jump:
			set_axis_velocity(Vector2(0,-jumpforce))
	