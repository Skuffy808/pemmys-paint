extends Node2D

@onready var animated_sprite = $AnimatedSprite2D
@onready var press_icon = $PressIcon   # <- New!

var dialogues = ["Dialogue1", "Dialogue2", "Dialogue3", "Dialogue4"]
var current_dialogue = 0

func _ready():
	press_icon.visible = false
	play_dialogues()

func play_dialogues() -> void:
	while true:
		var current_anim : String
		if current_dialogue < dialogues.size():
			current_anim = dialogues[current_dialogue]
		else:
			current_anim = dialogues[dialogues.size() - 1]

		animated_sprite.sprite_frames.set_animation_loop(current_anim, false)
		animated_sprite.play(current_anim)
		await wait_for_animation_end()

		# Show press icon because now waiting for input
		press_icon.visible = true
		print("Press Space to continue...")
		await wait_for_spacebar()

		# Hide it again once space is pressed
		press_icon.visible = false

		if current_dialogue < dialogues.size() - 1:
			current_dialogue += 1

func wait_for_animation_end() -> void:
	while animated_sprite.is_playing():
		await get_tree().process_frame

func wait_for_spacebar() -> void:
	while true:
		await get_tree().process_frame
		if Input.is_action_just_pressed("ui_accept"):
			break
