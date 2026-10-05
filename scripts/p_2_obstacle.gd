extends CharacterBody3D

const JUMP_VELOCITY = 3.1
const EMPURRAO = 0.6

@onready var colisao_normal: CollisionShape3D = $CollisionUp
@onready var colisao_abaixado: CollisionShape3D = $CollisionDowned
@onready var animation: AnimatedSprite3D = $AnimatedSprite3D

var esta_abaixado: bool = false
var pode_jogar: bool = true


func _ready() -> void:
	pass


func _physics_process(delta: float) -> void:
	if not pode_jogar:
		return

	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("ui_up") and is_on_floor() and not esta_abaixado:
		velocity.y = JUMP_VELOCITY

	_abaixar(Input.is_action_pressed("ui_down") and is_on_floor())

	velocity.x = 0
	velocity.z = 0

	move_and_slide()
	_atualizar_animacao()

func _abaixar(valor: bool) -> void:
	if valor == esta_abaixado:
		return
	esta_abaixado = valor
	colisao_normal.disabled = valor
	colisao_abaixado.disabled = not valor

func _atualizar_animacao() -> void:
	var pose := "idle"
	if not is_on_floor():
		pose = "jump"
	elif esta_abaixado:
		pose = "down"
	if animation.animation != pose:
		animation.play(pose)

func levar_hit(direcao_empurrao: Vector3) -> void:
	global_position += direcao_empurrao * EMPURRAO

func _on_death_area_body_entered(body: Node3D) -> void:
	pass
