DEBUG := 0
CARGO_PROFILE_FLAG := --release

.PHONY: help build-plugin test clean

help:
	@printf "Targets:\n"
	@printf "  make build-plugin               Build artifact\n"
	@printf "  make test                       Build plugin first, then run headless tests\n"
	@printf "  make clean                      Clean target dir\n"

build-plugin:
	cargo build $(CARGO_PROFILE_FLAG)

test: build-plugin
	cargo test

clean:
	rm -rf target
