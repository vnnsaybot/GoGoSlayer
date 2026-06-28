extends Node2D

@onready var player: CharacterBody2D = $Hero
@onready var stamina_bar: ProgressBar = $Interface/StaminaBar

func _process(delta: float) -> void:
	if player and stamina_bar:
		stamina_bar.value = player.current_stamina
