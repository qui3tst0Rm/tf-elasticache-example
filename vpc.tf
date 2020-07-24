provider "aws" {
  region = var.region
}


resource "aws_vpc" "swagger_api_vpc" {
  cidr_block           = var.vpc-cidr
  enable_dns_hostnames = true

  tags = {
    Name = "swagger_api_vpc"
  }
}

