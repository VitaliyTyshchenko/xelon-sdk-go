# Project variables
PROJECT_NAME := xelon-sdk-go

# Build variables
.DEFAULT_GOAL = test
BUILD_DIR := build


## tools: Install required tooling...
.PHONY: tools
tools:
	@curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s -- -b .bin/ v1.24.0


## clean: Delete the build directory.
.PHONY: clean
clean:
	@echo "==> Removing '$(BUILD_DIR)' directory..."
	@rm -rf $(BUILD_DIR)


## lint: Lint code with golangci-lint.
.PHONY: lint
lint:
	@echo "==> Linting code with 'golangci-lint'..."
	@.bin/golangci-lint run ./...


## test: Run all tests.
.PHONY: test
test:
	@echo "==> Running tests..."
	@mkdir -p $(BUILD_DIR)
	@go test -v -cover -coverprofile=$(BUILD_DIR)/coverage.out ./...


## build: Compile packages and dependencies.
.PHONY: build
build:
	@echo "==> Compiling packages..."
	@go build -o /dev/null ./...


help: Makefile
	@echo "Usage: make <command>"
	@echo ""
	@echo "Commands:"
	@sed -n 's/^##//p' $< | column -t -s ':' |  sed -e 's/^/ /'
