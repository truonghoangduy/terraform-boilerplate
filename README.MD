
### TERRAFORM

#### Installation
1. Install AWS SDK CLI
    1.1 **Required** AWS credential (login with required role)
2. Install Terraform SDK CLI

*Note contact mentor for AWS account role
```bash
aws configure
terraform apply

*If terminal output has "permission denied due to role"
re-check account permission/role to provision resource in AWS
```

#### Terraform Folder & Directory
```yml
// each folder has it own terraform input, output and variable 
modules:
        database: // AWS dynamoDB 
        gateway:  // AWS API Gateway with openapi standard (swagger exported)
        iam:      // AWS IAM, ROLE and POLICY
        lambda:   // AWS Lambda function bootstrap (zip, upload)
        lambda_permission: // binding AWS Lambda with other AWS like API Gateway for invoke-able permission
main.tf:         // course_app terraform infrastructure entry point, module bootstrapping
```
#### Terraform module dependency
```hcl
module "iam" {
  ...
}

module "database" {
  ...
}

module "lambda" {
  ...
  depends_on = [
    module.iam,
  ]
}

module "api-gateway" {
  ...
  depends_on = [
    module.lambda,
  ]
}

module "lambda_permission" {
  ...
  depends_on = [
    module.lambda,
    module.api-gateway
  ]
}
```