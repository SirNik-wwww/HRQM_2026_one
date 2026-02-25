class_name SaveGame
extends Resource

@export var pl_pos : Vector3 # позиция игрока
@export var pl_hp : int # здоровье игрока
@export var pl_was_crouching : bool # чтобы правильно загрузить позицию игрока если он был в присяде
@export var saved_data : Array [SavedData] = []
