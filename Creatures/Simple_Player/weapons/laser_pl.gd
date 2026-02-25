extends Area3D
class_name Laser_pl

@onready var ray_cast_3d: RayCast3D = $RayCast3D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var collision_shape_3d: CollisionShape3D = $CollisionShape3D

@export var scaler: Node3D

var dmg : int = 2
var distance : float
var shooted : bool = false


func _process(_delta: float) -> void:
	if shooted != true:
		shooted = !shooted
		if ray_cast_3d.is_colliding():
			var target_point = ray_cast_3d.get_collision_point()
			var raycast_pos = ray_cast_3d.global_position
			distance = raycast_pos.distance_to(target_point)
		else :
			distance = 100

		collision_shape_3d.scale.z = distance
		collision_shape_3d.position.z -= distance /2
		scaler.scale.z = distance
		scaler.position.z -= distance /2


		animation_player.play("fade_away")


func _on_timer_timeout() -> void:
	get_parent().remove_child(self)
	queue_free()



func _on_area_entered(area: Area3D) -> void:
	if area.has_method("take_damage"):
		area.take_damage(dmg, true)
