extends Camera2D


# переменные камеры
@onready var cooldown_zoom = $CooldownZoomTimer
var cam_pos: int = -1
var speed: float = 2
var speed_k: float = 1

# изменение зума камеры(1 до 1.5, -1 до 2.0)
func resize_camera(pos: int, cam_zoom: float, delta: float):
	if pos == 1 and cam_zoom >= 1.5:
		zoom.x -= speed * speed_k * delta
		zoom.y -= speed * speed_k * delta
		speed_k -= 0.03
	elif pos == -1 and cam_zoom <= 2:
		zoom.x += speed * speed_k * delta
		zoom.y += speed * speed_k * delta
		speed_k -= 0.3
	if speed_k <= 0.3:
		speed_k = 0.3

func _physics_process(delta: float) -> void:
	# камера
	if Input.is_action_pressed("camera_zoom"):
		if cooldown_zoom.is_stopped():
			cam_pos *= -1
			speed_k = 1
			cooldown_zoom.start()

	resize_camera(cam_pos, zoom.x, delta)
