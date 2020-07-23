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





