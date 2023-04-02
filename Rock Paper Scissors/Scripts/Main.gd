extends Node2D

# screen size = 1000x600

var base_players = ["Rock", "Paper", "Scissors"]
var extended_players = ["Lizard", "Spock"]
var scenes = []

var extended = true

var rand = RandomNumberGenerator.new()
var instances

func _ready():
    var spawn = 200
    instances = get_child(2)
    
    for name in base_players:
        scenes.append(load("res://Scenes/" + name + ".tscn"))
    if extended:
        for name in extended_players:
            scenes.append(load("res://Scenes/" + name + ".tscn"))
        
    for scene in scenes:
        for _i in range(spawn + 1):
            var instance = scene.instance()
            instance.position.x = rand.randi_range(100, 900)
            instance.position.y = rand.randi_range(50,550)
            instances.add_child(instance)
            
    for instance in instances.get_children():
        instance.set_velocity()
