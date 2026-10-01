extends RigidBody2D
@onready var bala: AnimatedSprite2D = $bala





# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$bala.play("run");
