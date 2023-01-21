extends Node

# ******************************************************************************

signal rx(message)

var websocket = WebSocketClient.new()

var connection_info = {
	ip = '127.0.0.1',
	port = 8000,
}

# ------------------------------------------------------------------------------

var prefix = '[color=green][CONTROLPORT][/color] '
func Log(string: String):
	Console.print(prefix + string)

# ******************************************************************************

# websocket needs to be polled
func _physics_process(delta):
	if websocket:
		websocket.poll()

func _ready():
	websocket.connect('connection_established', self, 'on_connection_established')
	websocket.connect('data_received', self, 'on_received_data')

# ******************************************************************************

var _handshake = {}

func connect_to_server(path, handshake):
	_handshake = handshake

	var url = 'ws://' + connection_info.ip + ':' + str(connection_info.port) + path
	Log("Attempting to connect to " + url)
	var result = websocket.connect_to_url(url)
	websocket.get_peer(1).set_write_mode(WebSocketPeer.WRITE_MODE_TEXT)
	if result != OK:
		Log("Failed to connect, error code: " + str(result))

func on_connection_established(protocol):
	Log('Connection successful, sending handshake')
	tx(_handshake)

func on_received_data():
	var packet: PoolByteArray = websocket.get_peer(1).get_packet()
	var json: JSONParseResult = JSON.parse(packet.get_string_from_utf8())
	if !json.error:
		var message: Dictionary = json.result
		Log('Received data: ' + packet.get_string_from_utf8())

		emit_signal('rx', message)

# ******************************************************************************

func tx(message):
	var packet: PoolByteArray = JSON.print(message).to_utf8()
	websocket.get_peer(1).put_packet(packet)
