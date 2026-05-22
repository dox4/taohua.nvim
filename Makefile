PACKAGE_NAME := taohua
PROFILE ?= debug
VALID_PROFILES := debug release

ifeq (,$(filter $(PROFILE),$(VALID_PROFILES)))
$(error Invalid PROFILE '$(PROFILE)'. Use PROFILE=debug or PROFILE=release)
endif

OS_NAME := $(shell uname -s)

ifeq ($(OS),Windows_NT)
LIB_PREFIX :=
LIB_EXT := dll
LUA_EXT := dll
else
LIB_PREFIX := lib
ifeq ($(OS_NAME),Darwin)
LIB_EXT := dylib
else
LIB_EXT := so
endif
LUA_EXT := so
endif

ifeq ($(PROFILE),release)
CARGO_PROFILE_FLAG := --release
else
CARGO_PROFILE_FLAG :=
endif

LIB_PATH := target/$(PROFILE)/$(LIB_PREFIX)$(PACKAGE_NAME).$(LIB_EXT)
LUA_PATH := lua/$(PACKAGE_NAME).$(LUA_EXT)

.PHONY: help build-plugin test

help:
	@printf "Targets:\n"
	@printf "  make build-plugin               Build debug artifact and copy to %s\n" "$(LUA_PATH)"
	@printf "  make build-plugin PROFILE=release  Build release artifact and copy to %s\n" "$(LUA_PATH)"
	@printf "  make test                       Build plugin first, then run headless tests\n"

build-plugin:
	cargo build $(CARGO_PROFILE_FLAG)
	mkdir -p lua
	cp "$(LIB_PATH)" "$(LUA_PATH)"
	@printf "Copied %s -> %s\n" "$(LIB_PATH)" "$(LUA_PATH)"

test: build-plugin
	cargo test
