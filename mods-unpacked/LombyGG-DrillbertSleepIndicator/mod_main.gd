extends Node

const MYMODNAME_MOD_DIR = "LombyGG-DrillbertSleepIndicator/"
const MYMODNAME_LOG = "LombyGG-DrillbertSleepIndicator"

var dir = ""
var ext_dir = ""

func _init(_modLoader:Node = ModLoader) -> void :
	ModLoaderLog.info("Init", MYMODNAME_LOG)
	dir = ModLoaderMod.get_unpacked_dir() + MYMODNAME_MOD_DIR
	ext_dir = dir + "extensions/"	
	ModLoaderMod.install_script_extension(ext_dir + "content/gadgets/drillbot/Drillbot.gd")

func _ready():
	ModLoaderLog.info("Done", MYMODNAME_LOG)
	add_to_group("mod_init")
	StageManager.connect("level_ready", listenToDrillbot)
	
func listenToDrillbot():
	if Data.of("drillbot.headcount") > 0:
		addDrillbertHud()
		Data.apply("drillbert.headcount", Data.of("drillbot.headcount"))
	Data.listen(self, "drillbot.headcount")

func propertyChanged(property:String, oldValue, newValue):
	match property:
		# ONLY LOWERCASE HERE
		"drillbot.headcount":
			if newValue == 1:
				addDrillbertHud()
			Data.apply("drillbert.headcount", newValue)
	
func addDrillbertHud():
	var _hud = Level.addHudElement(preload("res://mods-unpacked/LombyGG-DrillbertSleepIndicator/extensions/content/hud/DrillbertSleepingIndicator.tscn").instantiate())

func modInit() -> void :
	pass
