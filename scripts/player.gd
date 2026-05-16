extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var sprite = $AnimatedSprite2D
@onready var inventory = $Inventory
@onready var footstep = $FootstepPlayer
@onready var footstep_timer = $FootstepTimer


func _physics_process(delta: float) -> void:
	# Gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction := Input.get_axis("ui_left", "ui_right")

	if direction != 0:
		velocity.x = direction * SPEED

		if sprite.animation != "walk":
			sprite.play("walk")

		sprite.flip_h = direction < 0
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

		if sprite.animation != "idle":
			sprite.play("idle")

	move_and_slide()

	handle_footsteps(direction)


func handle_footsteps(direction):
	if direction != 0 and is_on_floor():
		if footstep_timer.is_stopped():
			footstep_timer.start()
	else:
		footstep_timer.stop()


func _on_footstep_timer_timeout():
	footstep.pitch_scale = randf_range(0.95, 1.05) # small variation
	footstep.play()
