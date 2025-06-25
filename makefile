BREW_PACKAGES := cosign tenv terraform-docs tflint checkov trivy

.PHONY: install
install:
	brew tap hashicorp/tap
	brew install $(BREW_PACKAGES)

.PHONY: chores
chores: format document

.PHONY: format
format: terraform fmt

.PHONY: document
document:
	terraform-docs -c .terraform-docs.yml .

.PHONY: format
format:
	terraform fmt

.PHONY: terratest
terratest:
	@echo "Not yet implemented."

.PHONY: terraform_test
terraform_test:
	@echo "Not yet implemented."

.PHONY: test_tflint
test_tflint:
	tflint --init
	tflint