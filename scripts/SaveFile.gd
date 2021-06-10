extends Node
var loadData
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
