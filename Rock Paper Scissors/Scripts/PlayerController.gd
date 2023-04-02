extends KinematicBody2D

enum characters{ROCK, PAPER, SCISSORS, SPOCK, LIZARD}

var speed
var direction
var rand = RandomNumberGenerator.new()
    
func _process(delta):
    
    move_and_slide(delta * direction * speed)
    check_collision()
        
func set_velocity():
    speed = rand.randf_range(40, 60)
    direction = Vector2(250,0).rotated(randf() * 2.0 * PI)

func check_collision():
    var p1 = get_player(name)
    var p2
    var changed = false
    for index in get_slide_count():
        var collision = get_slide_collision(index)
        if not changed  and collision.collider is StaticBody2D:
            changed = true
            direction = direction.bounce(collision.normal)                 
        if collision.collider is KinematicBody2D:
            p2 = get_player(collision.collider.name)
            var p1_won = play(p1,p2)
            if p1_won:
                collision.collider.queue_free()
            else:
                queue_free()
                return
            
func get_player(name):
    if "Rock" in name:
        return characters.ROCK
    if "Paper" in name:
        return characters.PAPER
    if "Scissors" in name:
        return characters.SCISSORS
    if "Lizard" in name:
        return characters.LIZARD
    if "Spock" in name:
        return characters.SPOCK 

func play(p1,p2):
    var compare = p1 - p2 + 5;
    if (compare % 5 + 1) % 2 == 0:
        return true
    return false
