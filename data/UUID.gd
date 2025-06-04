extends Node

func generator() -> String:
	# Parte 1: Timestamp (4 bytes = 8 hex)
	var timestamp = int(Time.get_unix_time_from_system())
	var ts_hex = "%08x" % timestamp

	# Parte 2: Identificador aleatorio (10 hex = 5 bytes)
	var rand_hex := ""
	for i in 5:
		var byte := randi() % 256
		rand_hex += "%02x" % byte  # 2 caracteres hex

	# Parte 3: Contador aleatorio (3 bytes = 6 hex)
	var counter := randi() % 0xFFFFFF
	var counter_hex = "%06x" % counter

	return ts_hex + rand_hex + counter_hex
