extends Node

var MasterVolume : float = 1.0
var MusicVolume : float = 1.0
var SFXVolume : float = 1.0

var _master_index : int = 0
var _sfx_index : int = 0
var _music_index : int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_master_index = AudioServer.get_bus_index("Master")
	_sfx_index = AudioServer.get_bus_index("SFX")
	_music_index = AudioServer.get_bus_index("Music")
	
	AudioServer.set_bus_volume_linear(_music_index, MusicVolume)
	AudioServer.set_bus_volume_linear(_sfx_index, SFXVolume)

func Set_Music_Volume(amount : float)->void:
	MusicVolume = amount
	AudioServer.set_bus_volume_linear(_music_index, MusicVolume)

func Get_Music_Volume() -> float:
	return MusicVolume

func Set_SFX_Volume(amount : float)->void:
	SFXVolume = amount
	AudioServer.set_bus_volume_linear(_sfx_index, SFXVolume)

func Get_SFX_Volume() -> float:
	return SFXVolume

func Set_Master_Volume(amount : float)->void:
	MasterVolume = amount
	AudioServer.set_bus_volume_linear(_master_index, MasterVolume)

func Get_Master_Volume() -> float:
	return MasterVolume
