extends Node
var loadData
var save_path = "user://save_slot1.dat"

func _ready():
	_on_Save_request()
	_on_Load_request()

func _on_Save_request():
	var data = {
		"coins" : GlobalVariables.coins,
		inventory = {
			
		},
		ships = {
			"total" : 0
		}
	}
	
	var file = File.new()
	var error = file.open_encrypted_with_pass(save_path, File.WRITE, "notchangethis")
	if error == OK:
		file.store_var(data)
		file.close()

func _on_Load_request():
	var file = File.new()
	if file.file_exists(save_path):
		var error = file.open_encrypted_with_pass(save_path, File.READ, "notchangethis")
		if error == OK:
			loadData = file.get_var()
			file.close()
