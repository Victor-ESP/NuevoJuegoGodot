extends CharacterBody2D
@onready var princesa: AnimatedSprite2D = $Princesa


const SPEED = 100.0
const JUMP_VELOCITY = -300.0
var velocidad = SPEED
var estaMuerta = false

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	if estaMuerta:
		velocity.x = 0
		move_and_slide()
		return

	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y = JUMP_VELOCITY
		
	elif Input.is_action_pressed("left") and Input.is_action_pressed("run"):
		velocity.x = -SPEED * 1.5
		$Princesa.flip_h = false
	elif Input.is_action_pressed("left"):
		velocity.x = -SPEED
		$Princesa.flip_h = false
	elif Input.is_action_pressed("right") and Input.is_action_pressed("run"):
		velocity.x = SPEED * 1.5
		$Princesa.flip_h = true
	elif Input.is_action_pressed("right"):
		velocity.x = SPEED
		$Princesa.flip_h = true
	else:
		velocity.x = 0;
	move_and_slide()


func _process(delta: float) -> void:
	if not estaMuerta:
		if is_on_floor():
			if velocity.x == 0:
				$Princesa.play("idle")
			elif Input.is_action_pressed("run"):
				$Princesa.play("run")
			else:
				$Princesa.play("walk")
		else:
			$Princesa.play("jump")
			
		if velocity.y > 0:
			$Princesa.play("fall")
		
	


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Princesa":
		if not estaMuerta:
			estaMuerta = true
			$Princesa.play("die")
		
