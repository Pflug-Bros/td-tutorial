extends StaticBody2D

var Bullet = preload("res://Scenes/Towers/red_bullet.tscn")
var bulletDamage = 5
var pathName
var enemiesInRange = []
var currentTargetPath = null

func evaluateCurrentTarget() -> void:
	if (currentTargetPath != null && !enemiesInRange.has(currentTargetPath.get_node("Enemy1"))):
		currentTargetPath = null
	print("evaluating current targets with size " + str(enemiesInRange.size()))
	for i in enemiesInRange:
		print("checking item " +str(i))
		if currentTargetPath == null:
			print("current target was null")
			currentTargetPath = i.get_parent()
		elif i.get_parent().get_progress() > currentTargetPath.get_progress():
			currentTargetPath = i.get_parent()
			print("current target changed to " + str(currentTargetPath))
		else:
			print("current target not changed")

func _on_tower_body_entered(body: Node2D) -> void:
	if "Enemy" in body.name:
		print("body entered: " + str(body))
		enemiesInRange.append(body)
		
		evaluateCurrentTarget()
		print("current target entered: " + str(currentTargetPath))
		print("-----------------")
		#print(enemiesInRange)
		#print(currentTargetPath)


func _on_tower_body_exited(body: Node2D) -> void:
	if "Enemy" in body.name:
		print("body exited: " + str(body))
		enemiesInRange.erase(body)
		
		if body.get_parent() == currentTargetPath:
			evaluateCurrentTarget()
	
		print("current target exited: " + str(currentTargetPath))
		print("-----------------")
