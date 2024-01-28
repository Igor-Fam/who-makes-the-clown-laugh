extends Node
class_name StateMachine

@export var initialState : State

var states : Dictionary = {}
var currentState: State
var previousStateName : String

func _ready():
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.Transitioned.connect(on_child_transition)
	
	if(initialState):
		initialState.enter()
		currentState = initialState

func _process(delta):
	if(currentState):
		currentState.state_update(delta)

func _physics_process(delta):
	if(currentState):
		currentState.state_physics_update(delta)

func on_child_transition(state : State, newStateName : String):
	if(state != currentState):
		return
	
	var newState = states.get(newStateName.to_lower())
	if(!newState):
		return
	
	if(currentState):
		currentState.exit()
	
	newState.enter()
	
	currentState = newState
