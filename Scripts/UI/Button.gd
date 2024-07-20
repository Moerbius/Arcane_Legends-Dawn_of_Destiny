extends TextureButton

@export var Text: String

#signal button_pressed

@onready var label = $Label
@onready var labelSettings: LabelSettings

# Called when the node enters the scene tree for the first time.
func _ready():
	#await get_tree().process_frame
	
	#label = Label.new()
	if(Text != null):
		label.text = Text
	else:
		label.text = "Merda"
		
	labelSettings = LabelSettings.new()
	labelSettings.font = load("res://Fonts/Alkhemikal.ttf")
	labelSettings.font_color = "#ffffff"
	label.label_settings = labelSettings


func _on_mouse_entered():
	labelSettings.font_color = "#CCCCCC"
	label.label_settings = labelSettings
	#print_debug("mouse entered")

func _on_mouse_exited():
	labelSettings.font_color = "#ffffff"
	label.label_settings = labelSettings
	#print_debug("mouse exited")


#func _on_button_play_pressed():
#	button_pressed.emit()
