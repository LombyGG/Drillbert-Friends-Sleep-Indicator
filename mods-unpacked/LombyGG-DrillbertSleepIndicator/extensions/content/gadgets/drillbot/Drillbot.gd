extends "res://content/gadgets/drillbot/Drillbot.gd"

func _ready():
	super()
	Data.listen(self, "drillbert.headcount", true)
	Data.listen(self, "drillbert.resethud", true)
	#Data.apply("drillbert.sleeping", name)
	#Data.apply("drillbert.headcount", Data.of("drillbot.headcount"))
	#Data.apply("drillbert.hitcount", 200)

#func wakeUp():
	#super()
	#Data.apply("drillbert.hitcount", Data.of("drillbot.amount"))
	
func setState(to):
	checkStatus(state, to)
	super(to)
		
func checkStatus(oldState:State, newState: State):		
	if newState != oldState:		
		if newState == State.SLEEPING:
			Data.apply("drillbert.sleeping", name)
		elif oldState == State.SLEEPING:
			Data.apply("drillbert.awake", name)


func resetStatus():
	if state == State.SLEEPING:
		Data.apply("drillbert.sleeping", name)
	else:
		Data.apply("drillbert.awake", name)

#func rotateUpright():
	#super()
	#Data.apply("drillbert.hitcount", remainingHits)
	
func propertyChanged(property:String, oldValue, newValue):
	match property:
		# ONLY LOWERCASE HERE
		"drillbert.headcount":
			if newValue > 0:
				resetStatus()
				
		"drillbert.resethud":
			resetStatus()
				
		_:
			super(property, oldValue, newValue)
