extends CharacterBody2D
@onready var enemigo: AnimatedSprite2D = $enemigo


const SPEED = 50.0
var velocidad_actual = SPEED

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	if not $RayCastDerecha.is_colliding():
		velocidad_actual = -SPEED
		$enemigo.flip_h = true
	if not $RayCastIzquierda.is_colliding():
		velocidad_actual = SPEED
		$enemigo.flip_h = false
	velocity.x = velocidad_actual
	move_and_slide()
	
func _process(delta: float) -> void:
	if velocity.x > 0 or velocity.x < 0:
		$enemigo.play("run")
	else:
		$enemigo.play("idle")
