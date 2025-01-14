extends "res://content/gadgets/drillbot/Drillbot.gd"

func _ready():
	super()
	checkStatus()		
	#Data.apply("drillbert.hitcount", 200)
	Data.listen(self, "drillbert.headcount", true)

#func wakeUp():
	#super()
	#Data.apply("drillbert.hitcount", Data.of("drillbot.amount"))
	
func setState(to):
	super(to)
	print(name)
	checkStatus()
		
func checkStatus():
	var counter = 0
	for drillbert in get_tree().get_nodes_in_group("drillbots"):
		if drillbert.state == State.SLEEPING:
			Data.apply("drillbert.sleeping", counter)
		else:
			Data.apply("drillbert.awake", counter)	
		counter += 1
	Data.apply("drillbert.awake", -1)	

func deserialize(data: Dictionary):
	super(data)	
	Data.apply("drillbert.headcount", Data.of("drillbot.headcount"))
	checkStatus()	

#func rotateUpright():
	#super()
	#Data.apply("drillbert.hitcount", remainingHits)
	
func propertyChanged(property:String, oldValue, newValue):
	match property:
		# ONLY LOWERCASE HERE
		"drillbert.headcount":
			if newValue > 0:
				checkStatus()				
		_:
			super(property, oldValue, newValue)
