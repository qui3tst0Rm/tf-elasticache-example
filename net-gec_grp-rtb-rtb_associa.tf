##############################################
##              Internet Gateway            ##
##############################################
resource "aws_internet_gateway" "swagger-gw" {
    vpc_id = aws_vpc.swagger_api_vpc.id
    tags = {
        Name = "swagger-app-igw"
    }
}

##############################################
##       Network Access Control List        ##
##############################################
resource "aws_network_acl" "nacl_b_all" {
  vpc_id = aws_vpc.swagger_api_vpc.id

  egress {
    from_port  = 0
    to_port    = 0
    protocol   = "-1"
    cidr_block = "0.0.0.0/0"
    rule_no    = 2
    action     = "allow"
  }
  ingress {
    from_port  = 0
    to_port    = 0
    protocol   = "-1"
    cidr_block = "0.0.0.0/0"
    rule_no    = 1
    action     = "allow"
  }
  tags = {
    Name = "open_nacl"
  }
}



##############################################
##              Route Tables                ##
##############################################
resource "aws_route_table" "routetb_A_public" {
  vpc_id = aws_vpc.swagger_api_vpc.id

  tags = {
    Name = "routetb_A_public"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.swagger-gw.id
  }
}



##############################################
##        Route Tables Association          ##
##############################################

# Jenkins route table association
resource "aws_route_table_association" "route-A-pub" {
  subnet_id      = aws_subnet.public_1.id
  route_table_id = aws_route_table.routetb_A_public.id
}



##############################################
##            Security Groups               ##
##############################################

##### Sec group for Jenkins box #####
resource "aws_security_group" "group_1" {
  name        = "sec_group_1"
  description = "sec group for jenkins server"
  vpc_id      = aws_vpc.swagger_api_vpc.id

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    #uncomment below cidr_block and set to your ip address then comment out above cidr_block to restrict access to your address only !
    #cidr_blocks = ["0.0.0.0/0"] 

  }
  #set to enable github hooks access where access has been restricted to a single ip address
  #Git Hooks IP address
  ingress {
    from_port = 8080
    to_port   = 8080
    protocol  = "tcp"
    #cidr_blocks = ["0.0.0.0/0"]
    cidr_blocks = ["192.30.252.0/22"]
  }

  #Git Hooks IP address
  ingress {
    from_port = 8080
    to_port   = 8080
    protocol  = "tcp"
    #cidr_blocks = ["0.0.0.0/0"]
    cidr_blocks = ["185.199.108.0/22"]
  }

  #Git Hooks IP address
  ingress {
    from_port = 8080
    to_port   = 8080
    protocol  = "tcp"
    #cidr_blocks = ["0.0.0.0/0"]
    cidr_blocks = ["140.82.112.0/20"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}