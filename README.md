# aws-infra

1. Install Terraform - brew tap hashicorp/tap
2. Install Terraform - brew install hashicorp/tap/terraform
3. Install AWS CLI - curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"
4. Install AWS CLI - sudo installer -pkg AWSCLIV2.pkg -target / 
6. Check the version of AWS CLI - aws --version

7. terraform init - To initialize
8. terraform plan - To check on what creation/updation will happen
9. terraform apply - To apply the changes or to create resources
10. terraform destroy - To destroy the resources
11. terraform destroy -lock=false  - To unlock the state and apply the changes