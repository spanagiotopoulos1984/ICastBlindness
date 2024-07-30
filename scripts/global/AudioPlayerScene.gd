extends AudioStreamPlayer

const map_music = preload("res://audio/shwomple.mp3")
const baked_bread = preload("res://audio/baked_bread.mp3")
const blindness = preload("res://audio/blindness.mp3")
const blindness_effect = preload("res://audio/blindness_effect.mp3")
const boing = preload("res://audio/Boing.mp3")
const dispel = preload("res://audio/dispel.mp3")
const door_open = preload("res://audio/door_open.mp3")
const fireball = preload("res://audio/fireball.mp3")
const freeze_effect = preload("res://audio/freeze_effect.mp3")
const gnome_alerted = preload("res://audio/gnome_alerted.mp3")
const gnome_mech_walkcycle = preload("res://audio/gnome_alerted.mp3")
const ice_cast = preload("res://audio/ice_cast.mp3")
const knock_knock = preload("res://audio/knock_knock.mp3")


func _play_music(music: AudioStream, volume=0.0):
	if stream == music:
		return
		 
	stream = music
	volume_db = volume
	play()
	
func play_level_music():
	_play_music(map_music)

func play_fx(stream: AudioStream, volume=0.0):
	var fx_player = AudioStreamPlayer.new()
	fx_player.stream = stream
	fx_player.name = "FX_PLAYER"
	fx_player.volume_db = volume
	
	add_child(fx_player)

	fx_player.play()
	
	await fx_player.finished
	fx_player.queue_free()
	
