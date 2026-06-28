extends CharacterBody2D

# Переменные героя
var base_speed: float = 150.0
var sprint_bonus: float = 70.0 
var max_stamina: float = 100.0
var stamina_drain_rate: float = 20.0
var stamina_regen_rate: float = 5.0

@onready var anim = $AnimatedSprite2D
@onready var cooldown_stamina = $CooldownStaminaTimer

var current_stamina: float = max_stamina
var is_sprinting: bool = false

func _physics_process(delta: float) -> void:
	# создание Vector2
	var direction = Input.get_vector("left", "right", "up", "down")
	
	# бег и стамина
	if direction != Vector2.ZERO and Input.is_action_pressed("shift") and current_stamina > 0:
		is_sprinting = true
		current_stamina -= stamina_drain_rate * delta
	else:
		if is_sprinting:
			is_sprinting = false
			cooldown_stamina.start()
		
		if cooldown_stamina.is_stopped():
			current_stamina += stamina_regen_rate * delta
		
	current_stamina = clamp(current_stamina, 0.0, max_stamina)
	

	if current_stamina <= 0:
		if is_sprinting:
			is_sprinting = false
			cooldown_stamina.start()
	

	var current_speed = base_speed
	if is_sprinting:
		current_speed += sprint_bonus
	
	velocity = direction * current_speed
	move_and_slide()
	
	update_animations(direction)


# анимации
func update_animations(direction: Vector2) -> void:
	if direction == Vector2.ZERO:
		anim.stop() 
	elif direction.x > 0 and direction.y > 0:
		anim.play("front-right")
	elif direction.x < 0 and direction.y > 0:
		anim.play("front-left")
	elif direction.x > 0 and direction.y < 0:
		anim.play("back-right")
	elif direction.x < 0 and direction.y < 0:
		anim.play("back-left")
	elif direction.x > 0:
		anim.play("right")
	elif direction.x < 0:
		anim.play("left")
	elif direction.y > 0:
		anim.play("front")
	elif direction.y < 0:
		anim.play("back")
