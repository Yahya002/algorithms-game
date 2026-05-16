extends Area2D

@onready var sprite = $AnimatedSprite2D
@onready var label = $Index/Label
@onready var pointer = $Pointer
@onready var open_sound = $OpenSound

@export var index_number := 0
@export var chest_value := 0

var player_in_range = false
var is_open = false
var player_inventory = null

func _ready():
	label.text = str(index_number)
	sprite.play("default")
	hide_pointer()


func _on_body_entered(body):
	if body.is_in_group("player"):
		player_in_range = true
		
		if body.has_node("Inventory"):
			player_inventory = body.get_node("Inventory")
			

func _on_body_exited(body):
	if body.is_in_group("player"):
		player_in_range = false
		player_inventory = null


func _process(delta):
	if player_in_range and Input.is_action_just_pressed("interact"):
		try_open()


func try_open():
	if is_open:
		print("Chest already opened")
		return
		
	if player_inventory == null:
		return
		
	if not player_inventory.has_key():
		print("Need a key!")
		return

	player_inventory.use_key()

	# 🔥 Notify manager BEFORE opening
	var manager = get_tree().get_first_node_in_group("manager")
	if manager:
		manager.chest_opened(self)

	open_chest()
func open_chest():
	is_open = true
	sprite.play("open")

	# Prevent overlapping
	if open_sound.playing:
		open_sound.stop()

	# Optional realism
	open_sound.pitch_scale = randf_range(0.95, 1.05)
	open_sound.play()

	show_value()


func show_value():
	var popup = Label.new()
	popup.text = str(chest_value)
	popup.position = Vector2(0, -40)
	add_child(popup)

	var tween = create_tween()
	tween.tween_property(popup, "position", popup.position + Vector2(0, -20), 1.0)
	tween.parallel().tween_property(popup, "modulate:a", 0.0, 1.0)

	await tween.finished
	popup.queue_free()


func show_pointer():
	if pointer:
		pointer.visible = true


func hide_pointer():
	if pointer:
		pointer.visible = false
