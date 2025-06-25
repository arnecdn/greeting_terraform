BREW_PACKAGES := cosign tenv terraform-docs tflint checkov trivy

.PHONY: install
install:
	brew tap hashicorp/tap
	brew install $(BREW_PACKAGES)

.PHONY: chores
chores: documentation format

.PHONY: documentation
documentation:
	terraform-docs -c .terraform-docs.yml .

.PHONY: test_documentation
test_documentation:
	terraform-docs -c .terraform-docs.yml --output-check .

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

.PHONY: security
security: test_checkov

.PHONY: test_checkov
test_checkov:
	checkov --directory .