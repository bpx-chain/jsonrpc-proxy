ORG_NAME := bpx-chain
REPO_NAME := jsonrpc-proxy
PKG_ROOT := github.com/${ORG_NAME}/$(REPO_NAME)
PKG_LIST := go list ${PKG_ROOT}/...
PKG_GO_JSONRPC_PROXY := ${PKG_ROOT}/cmd
CMD_DIR := ./cmd

.PHONY: all lint vet test jsonrpc-proxy

.EXPORT_ALL_VARIABLES:

GO111MODULE=on

all: lint vet test jsonrpc-proxy

vet:
	@go vet $(shell $(PKG_LIST))

# Lint the files
lint:
	@golint -set_exit_status $(shell $(PKG_LIST))

# Run unit tests
test:
	@go test -v -short -count=1 $(shell $(PKG_LIST))

jsonrpc-proxy: $(CMD_DIR)/jsonrpc-proxy

$(CMD_DIR)/jsonrpc-proxy:
	@echo "Building $@..."
	@go build -i -o $(CMD_DIR)/jsonrpc-proxy -v $(PKG_GO_JSONRPC_PROXY)
	@chmod u+x $(CMD_DIR)/jsonrpc-proxy

clean:
	@rm -df $(CMD_DIR)/jsonrpc-proxy