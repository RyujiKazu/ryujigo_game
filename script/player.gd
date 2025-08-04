extends CharacterBody2D


const SPEED = 350.0
const JUMP_VELOCITY = -790.0
@onready var player_2d: AnimatedSprite2D = $AnimatedSprite2D


func _physics_process(delta: float) -> void:
	#
	if velocity.x > 0 or velocity.x < 0:
		player_2d.animation = "run"
	else:
		player_2d.animation = "idle"
		
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		player_2d.animation = "jump"

	# Handle jump.
	if Input.is_action_just_pressed("lompat") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction: 
		player_2d.flip_h = direction < 0
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
