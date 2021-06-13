extends Node
var loadData = {
		"coins" : 0,
		"totalShips" : 0,
		inventory = {
			"wine": 0
		},
		ships = {
			
		},
		taxesship = {
			
		},
		shipyards = {
			
		},
		upgrades = {
			"compass": false,
			"cartography": false,
			"astrolabe": false,
			"Madeira": 1,
			"canhao": 1,
			"vela": 1,
			"arquitetura_nautica": 1
		},
		locations = {}
	}
var data
var save_path = ""

func Save_request():
	var file = File.new()
	var error = file.open_encrypted_with_pass(save_path, File.WRITE, "notchangethis")
	if error == OK:
		file.store_var(data)
		file.close()

func Load_request():
	var file = File.new()
	if file.file_exists(save_path):
		var error = file.open_encrypted_with_pass(save_path, File.READ, "notchangethis")
		if error == OK:
			loadData = file.get_var()
			file.close()
