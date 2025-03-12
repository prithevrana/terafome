- name: Change to Terraform directory
  run: cd terraform && terraform init

- name: Validate Terraform configuration
  run: cd terraform && terraform validate

- name: Terraform Plan
  run: cd terraform && terraform plan -out=tfplan
