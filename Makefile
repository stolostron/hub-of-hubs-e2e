
 verbose ?= 5

.PHONY: fmt				
fmt:
	@gci overwrite ./pkg/
	@go fmt ./pkg/...
	@gofumpt -w ./pkg/

.PHONY: check
check: fmt
	@./cicd-scripts/check-variables.sh

.PHONY: connection
connection: fmt check
	@./cicd-scripts/run-tests.sh -f "connection" -v $(verbose)

.PHONY: label
label: fmt check
	@./cicd-scripts/run-tests.sh -f "label" -v $(verbose)

.PHONY: policy
policy: fmt check
	@./cicd-scripts/run-tests.sh -f "policy" -v $(verbose)

.PHONY: app 
app: fmt check
	@./cicd-scripts/run-tests.sh -f "app" -v $(verbose)

.PHONY: all
all: fmt check
	@./cicd-scripts/run-tests.sh -f "connection && label && policy && app" -v $(verbose)

.PHONY: vendor			
vendor:
	@go mod vendor

.PHONY: clean-vendor		
clean-vendor:
	-@rm -rf vendor
