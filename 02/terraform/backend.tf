terraform {
  backend "s3" {
    bucket         = "prueba-devops-terraform-state"
    key            = "terraform.tfstate"
    region         = "us-east-1"

    dynamodb_table = "terraform_locks"
    encrypt        = true
  }
}
