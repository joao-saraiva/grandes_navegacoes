extends Node

const serial_res = preload("res://bin/gdserial.gdns")
onready var serial_port = serial_res.new()

var is_port_open = false
var text = ""

signal menu()
signal select()
signal controle(value)


func _ready():
	open()
	pass
	
func _exit_tree():
	close()

func open():
	is_port_open = serial_port.open_port("COM3", 9600)
	print(is_port_open)
	
func write(text):
	serial_port.write_text(text)
	
func close():
	is_port_open = false
	serial_port.close_port()

func _process(delta):
	if is_port_open:
		var t = serial_port.read_text()
		
		if t.length() > 0:
			for c in t:
				if c == "\n":
					on_text_received(text)
					text = ""
				else:
					text+=c
			#print(t)
		

func on_text_received(text): #"1 Sobe"
	var command_array = text.split(" ")
	#print(command_array)
	if command_array.size() < 1:
		return
		
	if str(command_array[0]) == "Select":
		emit_signal("select")
	elif command_array[0] == "Menu":
		emit_signal("menu")
	else:
		emit_signal("controle", command_array[1])
