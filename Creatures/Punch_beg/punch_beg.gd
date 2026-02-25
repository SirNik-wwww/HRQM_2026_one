extends CharacterBody3D

## Это именно "Punch beg", а не "Punch bag"

@onready var anim_sp_pl = $AnimatedSprite3D

var lives = 10

var gravity = 12.0

var beatable = true # определяет может ли груша получать урон




func damage():
	if beatable == true:
		beatable = !beatable
		if lives >= 1:
			anim_sp_pl.play("damage")
			velocity.y += 5
			await get_tree().create_timer(0.2).timeout
			anim_sp_pl.play("idle")
			beatable = !beatable
		else:
			die()


func die():
	beatable = false
	anim_sp_pl.play("die")
	await get_tree().create_timer(1).timeout
	queue_free()


func _physics_process(delta: float) -> void:
	if !is_on_floor():
		velocity.y -= gravity * delta
	
	move_and_slide()
