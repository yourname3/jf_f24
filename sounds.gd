extends Node

@onready var music_game = $MusicGame
@onready var music_gallery = $MusicGallery

@onready var jump_normal = $JumpNormal
@onready var jump_cheese = $JumpCheese
@onready var grab = $Grab
@onready var release = $Release

@onready var ow = $Ow
@onready var hooray = $Hooray

@onready var hover_on = $HoverOn
@onready var hover_off = $HoverOff

@onready var swoosh = $Swoosh

# Current energy which steps towards goal energy. Represents the energy of
# music_game.
var current_energy = 0.0

func _ready():
	music_game.play()
	music_gallery.play()

func _process(delta):
	var goal_energy = 0.0
	# Just look for level nodes to set the energy to higher.
	if get_tree().get_node_count_in_group("Level") > 0:
		goal_energy = 1.0
		
	# If we're in the gallery level, it'sd still 0.0.
	if get_tree().get_node_count_in_group("Gallery") > 0:
		goal_energy = 0.0
		
	current_energy += (goal_energy - current_energy) * 0.05
	
	music_game.volume_db = linear_to_db(current_energy)
	music_gallery.volume_db = linear_to_db(1.0 - current_energy)
