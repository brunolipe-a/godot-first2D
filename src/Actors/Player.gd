extends Actor

export var stomp_bounce := 1000.0

func _on_EnemyDetector_area_entered(area: Area2D) -> void:
	_velocity = calculate_stomp_velocity(_velocity, stomp_bounce)
	
func _on_EnemyDetector_body_entered(body: Node) -> void:
	queue_free()

func _physics_process(delta: float) -> void:
	var is_jumping_interroped = Input.is_action_just_released("jump") and _velocity.y < 0.0
	var direction := get_direction()

	_velocity = calculate_move_velocity(_velocity, direction, _speed, is_jumping_interroped)

	_velocity = move_and_slide(_velocity, FLOOR_NORMAL)


func get_direction() -> Vector2:
	var right_movement := Input.get_action_strength("move_right")
	var left_movement := Input.get_action_strength("move_left")
	var is_jumping := Input.is_action_just_pressed("jump") and is_on_floor()
	
	return Vector2(
		right_movement - left_movement,
		-1.0 if is_jumping else 1.0
	)

func calculate_move_velocity(linear_velocity: Vector2, direction: Vector2, speed: Vector2, is_jumping_interroped: bool) -> Vector2:
	var out = linear_velocity

	out.x = direction.x * speed.x
	out.y += _gravity * get_physics_process_delta_time()

	if direction.y == -1.0:
		out.y = speed.y * direction.y
	if is_jumping_interroped:
		out.y = 0.0

	return out
	
func calculate_stomp_velocity(linear_velocity: Vector2, bounce: float) -> Vector2:
	var out := linear_velocity
	out.y = -bounce

	return out
