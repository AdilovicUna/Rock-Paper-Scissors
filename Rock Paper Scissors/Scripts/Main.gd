extends Node2D

onready var menu = get_node("UI/MainMenu")
onready var restart = get_node("UI/Restart")

# screen size = 1000x600


var base_players = ["Rock", "Paper", "Scissors"]
var extended_players = ["Lizard", "Spock"]
var scenes = []

var rand = RandomNumberGenerator.new()
var instances

var spawn = 100
var extended = false

var generated = false

func _physics_process(_delta):
    if generated and all_same():
        $UI/Restart/WinMessage.text = get_type(instances.get_child(0).name) + " Won!"
        generated = false
        for instance in instances.get_children():
            instance.queue_free()
        restart.show()

func all_same():
    var first_child = instances.get_child(0)
    var type = get_type(first_child.name)
        
    for instance in instances.get_children():
        if get_type(instance.name) != type:
            return false
    return true
        
func get_type(name):
    if "Rock" in name:
        return "Rock"
    if "Paper" in name:
        return "Paper"
    if "Scissors" in name:
        return "Scissors"
    if "Lizard" in name:
        return "Lizard"
    if "Spock" in name:
        return "Spock"

func generate():
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

func _on_Start_pressed():
    menu.hide()
    generate()
    generated = true

func _on_Size_value_changed(value):
    spawn = value

func _on_ExtendedCheckbox_toggled(button_pressed):
    extended = button_pressed

func _on_Restart_pressed():
    restart.hide()
    menu.show()


