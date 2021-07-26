.DEFAULT_GOAL := help

.SILENT : help

company := home
project := terraform
version := 0.0.1

## Initializes Terraform
init:
	@cd providers/aws; terraform init

## Plan infrastructure
plan:
	@cd providers/aws; terraform plan -out=PLANFILE

## Apply infrastructure
apply:
	@cd providers/aws; terraform apply PLANFILE; rm -rf PLANFILE


## show help screen
help:
	printf "\n$(company) - $(project) v$(version)\n"
	printf "\nUsage:\n make <target>\n\nTargets:\n"
	awk '/^[a-zA-Z\-\_0-9]+:/ { \
        helpMessage = match(lastLine, /^## (.*)/); \
        if (helpMessage) { \
          helpCommand = substr($$1, 0, index($$1, ":")-1); \
          helpMessage = substr(lastLine, RSTART + 3, RLENGTH); \
          printf "  \033[32m%-15s\033[0m %s\n", helpCommand, helpMessage; \
        } \
    } \
    { lastLine = $$0 }' $(MAKEFILE_LIST)