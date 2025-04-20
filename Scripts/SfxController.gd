extends Node

@onready var streamWalk = $StreamWalk
#@onready var streamJump = $StreamJump
#@onready var streamDeath = $StreamDeath
#@onready var streamNewArea = $StreamNewArea
#@onready var streamStick = $StreamStick
#@onready var streamCrawl = $StreamCrawl
#@onready var streamGun = $StreamGun

enum SFX {
	#NEW_AREA,
	WALK#,
	#JUMP,
	#DEATH,
	#STICK,
	#CRAWL,
	#GUN
}

#TODO: falta o resto dos sons..
func play_sfx(sfx: SFX):
	
	match sfx:
		#SFX.NEW_AREA:
		#	streamNewArea.play()
		SFX.WALK:
			if !streamWalk.is_playing():
				streamWalk.play()
		#SFX.JUMP:
		#	if streamWalk.is_playing():
		#		streamWalk.stop()
		#	if !streamJump.is_playing():
		#		streamJump.play()
		#SFX.DEATH:
		#	streamDeath.play()
		#SFX.STICK:
		#	if streamWalk.is_playing():
		#		streamWalk.stop()
		#	streamStick.play()
		#SFX.CRAWL:
		#	if !streamCrawl.is_playing():
		#		streamCrawl.play()
		#SFX.GUN:
		#	streamGun.play()
