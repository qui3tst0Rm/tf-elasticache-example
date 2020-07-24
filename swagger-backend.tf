terraform {
  backend "s3" {
    bucket = "chin-bucket"
    key    = "swagger-app-terraform-tfstate"
    region = "eu-west-2"
  }
}