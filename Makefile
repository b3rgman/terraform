.DEFAULT_GOAL := help

.SILENT : help
.Phony : apply init plan destroy destroy-confirm clean validate

company := home
project := terraform
version := 0.0.1

# defaults
PROVIDER := aws
PLANFILE := terraform.planfile

## Clean structure
clean:
	@rm -f ./providers/${PROVIDER}/${PLANFILE}
	@rm -f ./providers/${PROVIDER}/destroy.plan

## Initializes Terraform
init:
	@cd providers/aws; terraform init

## Plan infrastructure
plan: clean init
	@cd providers/${PROVIDER}; terraform plan -out=${PLANFILE}

## Apply infrastructure
apply:
	@cd providers/${PROVIDER}; terraform apply ${PLANFILE}; cat terraform.tfstate | grep public_ip

## Destroy Plan
destroy: clean
	@cd providers/${PROVIDER}; terraform plan -destroy -out=destroy.plan

## Destroy Infrastructure Confirmation
destroy-confirm:
	@cd providers/${PROVIDER}; terraform apply destroy.plan

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