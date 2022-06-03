# **************************************************************************** #
# General Make configuration

# This suppresses make's command echoing. This suppression produces a cleaner output. 
# If you need to see the full commands being issued by make, comment this out.
MAKEFLAGS += -s

# **************************************************************************** #
# Targets

pull:
	git reset --hard
	git pull

web:
	$(GODOT) --export "HTML5"

webdeploy: web
	cp build/web/* ~/www/html/skyknights

win:
	$(GODOT) --export "Windows Desktop"

.PHONY: server
server:
	$(GODOT) --export-debug "Server"

runserver:
	build/win_server/IsotopeServer.exe

serve: venv
	$(VENV_PYTHON) server/main.py

# **************************************************************************** #
# Variables

WSLENV ?= notwsl

GD = ""
ifndef WSLENV
	GD := godot.exe
else
	GD := ~/godot/Godot_v3.5-beta5_linux_headless.64
endif

GDARGS := --no-window --quiet

GODOT = $(GD) $(GDARGS)

# **************************************************************************** #

include venv.mk