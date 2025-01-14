extends HudElement

var sleepCounterShown = false
var totalDinos = 0
var totalDinosAsleep = 0

func _ready():
	Style.init(self)
	element_size = Vector2(6, 3)
	$Drillbert.hide()
	$Drilliam.hide()
	$Diggory.hide()
	$Minerva.hide()
	$Drillbert.scale = Vector2(1, 1)
	$Drillbert.position = Vector2(19, 6)
	$Drillbert.frame_coords.y = 0
	$Drilliam.frame_coords.y = 20
	$Diggory.frame_coords.y = 30
	$Minerva.frame_coords.y = 40
	Data.listen(self, "drillbert.sleeping", true)
	Data.listen(self, "drillbert.awake", true)
	#Data.listen(self, "drillbert.hitcount", true)
	Data.listen(self, "drillbert.headcount", true)

func propertyChanged(property:String, oldValue, newValue):
	match property:
		# ONLY LOWERCASE HERE
		"drillbert.headcount":
			totalDinos = newValue
			#$TotalCount.text = str(newValue)
			sleepCounterShown = false
			if newValue == 0:				
				element_size = Vector2(1, 1)
			if newValue > 0:
				$Drillbert.show()		
			if newValue > 1:
				element_size = Vector2(4, 3)
				$Drillbert.scale = Vector2(0.5, 0.5)
				$Drillbert.position = Vector2(13, 3)
				$Drilliam.show()				
			if newValue > 2:
				element_size = Vector2(7, 3)
				$Diggory.show()
			if newValue > 3:
				$Minerva.show()
			if newValue > 4:
				$Diggory.hide()
				$Minerva.hide()
				$Drillbert.frame_coords.y = 0
				$Drillbert/Sleep.hide()
				$Drillbert/Sleep2.hide()
				$Drilliam.frame_coords.y = 23
				$Drilliam/Sleep.show()
				$Drilliam/Sleep2.show()
				$SleepCount.show()
				$AwakeCount.show()
				$TotalCount.hide()
				sleepCounterShown = true
				element_size = Vector2(5, 3)
			
		"drillbert.sleeping":
			if newValue == 0:
				totalDinosAsleep = 0
			if sleepCounterShown:
				totalDinosAsleep += 1
			else:
				match newValue:
					0:				
						$Drillbert.frame_coords.y = 3
						$Drillbert/Sleep.show()
						$Drillbert/Sleep2.show()
					1:
						$Drilliam.frame_coords.y = 23
						$Drilliam/Sleep.show()
						$Drilliam/Sleep2.show()
					2:
						$Diggory.frame_coords.y = 33
						$Diggory/Sleep.show()
						$Diggory/Sleep2.show()
					3:
						$Minerva.frame_coords.y = 43
						$Minerva/Sleep.show()
						$Minerva/Sleep2.show()
					_:
						pass
				
		"drillbert.awake":
			if newValue == 0:
				totalDinosAsleep = 0
			if sleepCounterShown:
				if newValue == -1:
					setCounters()
			else:
				match newValue:
					0:			
						$Drillbert.frame_coords.y = 0
						$Drillbert/Sleep.hide()
						$Drillbert/Sleep2.hide()
					1:
						$Drilliam.frame_coords.y = 20
						$Drilliam/Sleep.hide()
						$Drilliam/Sleep2.hide()
					2:
						$Diggory.frame_coords.y = 30
						$Diggory/Sleep.hide()
						$Diggory/Sleep2.hide()
					3:
						$Minerva.frame_coords.y = 40
						$Minerva/Sleep.hide()
						$Minerva/Sleep2.hide()				
					_:
						pass

		"drillbert.hitcount":
			#$Awake/Label.text = str(newValue)		
			pass	
			
		
func setCounters():
	$AwakeCount.text = str(totalDinos - totalDinosAsleep)
	$SleepCount.text = str(totalDinosAsleep)
	
