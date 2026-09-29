extends CharacterBody2D
@onready var princesa: AnimatedSprite2D = $Princesa


const SPEED = 100.0
const JUMP_VELOCITY = -200.0
var velocidad = SPEED
var estaMuerta = false

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

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
		if not is_on_floor() and velocity.y < 0:
			$Princesa.play("jump")
		elif velocity.x == 0 and is_on_floor():
			$Princesa.play("idle")
		if velocity.y > 0:
			$Princesa.play("fall")
		if is_on_floor() and Input.is_action_pressed("run"):
			$Princesa.play("run")
		elif is_on_floor() and velocity.x < 0 or velocity.x > 0:
			$Princesa.play("walk")
	elif estaMuerta:
		$Princesa.play("die")
		velocity.x = 0
	
	


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Princesa":
		estaMuerta = true
		

func _on_area_2d_body_exited(body: Node2D) -> void:
	estaMuerta = false
