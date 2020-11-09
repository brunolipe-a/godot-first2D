class_name Actor
extends KinematicBody2D

export var _speed := Vector2(800.0, 1400.0)
export var _gravity := 3000.0

var _velocity := Vector2.ZERO
const FLOOR_NORMAL := Vector2.UP
