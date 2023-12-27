@tool
extends Interactable

var prompt_action := "interact":
	set(value):
		prompt_action = value
		gen_prompt_string()

@onready var prompt_string_base := "Press {prompt} to interact"

@onready var label : Label = $Prompt/Label

var prompt_string : String
var is_prompting = false

signal prompt_responded



func _enter_tree():
	label = $Prompt/Label
	prompt_string_base = "Press \"{prompt}\" to interact"

func _ready():
	gen_prompt_string()

func gen_prompt_string():
	if not label:
		return
#	var event = ProjectSettings.get("input/{action}".format({"action": prompt_action}) )
#	print(event)
	prompt_string = prompt_string_base.format({"prompt":prompt_action.capitalize()})
	label.text = prompt_string

func _get_property_list():
	var actions = []
	for prop in ProjectSettings.get_property_list():
		var prop_name:String = prop.get("name", "")
		if prop_name.begins_with('input/') and not prop_name.begins_with("input/ui"):
			prop_name = prop_name.replace('input/', '') 
			prop_name = prop_name.substr(0, prop_name.find("."))
			if not actions.has(prop_name):
				actions.append(prop_name)
	
	var hint_string = ",".join(actions)
	
	var properties = []
	properties.append({
		"name": "prompt_action",
		"type": TYPE_STRING_NAME,
		"hint": PROPERTY_HINT_ENUM,
		"hint_string": hint_string
	})
	return properties

func _input(event):
	if event.is_action_pressed(prompt_action):
		handle_prompt_responded()

func handle_prompt_responded():
	prompt_responded.emit()

func _on_body_entered(body):
	super._on_body_entered(body)
	if body is Player:
		$Prompt.show()
		is_prompting = true
	

func _on_body_exited(body):
	if body is Player:
		$Prompt.hide()
		is_prompting = false
	pass # Replace with function body.
