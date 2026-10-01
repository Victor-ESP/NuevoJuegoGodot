extends RigidBody2D
@onready var aro_de_fuego: AnimatedSprite2D = $aroDeFuego


# Called when the node enters the scene tree for the first time.
func _process(delta: float) -> void:
	$aroDeFuego.play("default");
