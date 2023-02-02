@tool
extends Node

# ******************************************************************************

var _start_time = 0.0

func begin():
	_start_time = Time.get_ticks_msec()

func lap(label=''):
	var time = Time.get_ticks_msec() - _start_time
	print('[%s] %s' % [time, label])
	return time
