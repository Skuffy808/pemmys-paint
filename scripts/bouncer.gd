extends Node2D

var velocity = Vector2(200, 150) # pixels per second

func _process(delta):
	position += velocity * delta

	var screen_size = get_viewport_rect().size
	var sprite_size = get_node("Sprite2D").texture.get_size()

	# Bounce on X axis
	if position.x <= 0 or position.x + sprite_size.x >= screen_size.x:
		velocity.x = -velocity.x
		position.x = clamp(position.x, 0, screen_size.x - sprite_size.x)

	# Bounce on Y axis
	if position.y <= 0 or position.y + sprite_size.y >= screen_size.y:
		velocity.y = -velocity.y
		position.y = clamp(position.y, 0, screen_size.y - sprite_size.y)
