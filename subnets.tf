# Jenkins subnet
resource "aws_subnet" "public_1" {
  vpc_id            = aws_vpc.swagger_api_vpc.id
  cidr_block        = var.jenkins-subnet-cidr
  availability_zone = "eu-west-2a"

  tags = {
    Name = "public-subnet-1-jenkins"
  }
  map_public_ip_on_launch = true
}

# Swagger app subnet
resource "aws_subnet" "public_2" {
  vpc_id            = aws_vpc.swagger_api_vpc.id
  cidr_block        = var.swagger-app-subnet-cidr
  availability_zone = "eu-west-2b"

  tags = {
    Name = "public-subnet-2-swagger"
  }
  map_public_ip_on_launch = true
}

# Redis cluster subnet
resource "aws_subnet" "private_1" {
  vpc_id            = aws_vpc.swagger_api_vpc.id
  cidr_block        = var.redis-cluster-subnet-cidr
  availability_zone = "eu-west-2c"

  tags = {
    Name = "private-subnet-1-Redis"
  }
}



