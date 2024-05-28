class_name itemManager

extends Node

func drop(item, bluePrint, transform, dir):
	item.queue_free()
	var newItem = bluePrint.instantiate()
	newItem.global_transform = transform
	newItem.apply_force(dir * 2000)
	item.get_tree().get_current_scene().add_child(newItem)
	
func pickUp(item, bluePrint):
	item.queue_free()
	return bluePrint.instantiate()

func highlight(sprite, equipped):
	if not equipped:
		sprite.play("highlighted")

func unHighlight(sprite, equipped):
	if not equipped:
		sprite.play("default")
