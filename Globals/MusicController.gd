extends Node

@onready var stream = $Stream

var mus_Main = load("res://Music/main_title.mp3")
var mus_town = load("res://Music/town_theme.mp3")

#var mus_SouthAmerica = load("res://Music/samerica-st.mp3")
#var mus_Egypt = load("res://Music/egypt-st.mp3")
#var mus_Schwarz = load("res://Music/schwarz-st.mp3")
#var mus_MissileBase = load("res://Music/mbase-st.mp3")

enum Musics {
	MAIN,
	TOWN#,
	#EGYPT,
	#SCHWARZ,
	#MISSILEBASE
}

@onready var isPlaying

func _process(_delta):
	isPlaying = stream.is_playing()

func play_music(mus):
	match mus:
		Musics.MAIN:
			stream.stream = mus_Main
			stream.play()
		Musics.TOWN:
			stream.stream = mus_town
			stream.play()
			#Global.load_level("res://0 South America/scenes/sa1.tscn")

func stop_music():
	stream.stop()
