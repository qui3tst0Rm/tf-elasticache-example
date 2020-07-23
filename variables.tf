variable "region" {
  default = "eu-west-2"
}

variable "vpc-cidr" {
  default     = "172.28.0.0/16"
  description = "swagger-app-vpc-cidr"
}

variable "jenkins-subnet-cidr" {
  default     = "172.28.8.0/24"
  description = "jenkins-subnet-cidr"
}

variable "swagger-app-subnet-cidr" {
  default = "172.28.16.0/24"
  description = "swagger-app-subnet-cidr"
}

variable "redis-cluster-subnet-cidr" {
  default = "172.28.24.0/24"
  description = "redis-cluster-subnet-cidr"
}

variable "ec2-ami" {
  default = "ami-032598fcc7e9d1c7a"
  #default = "ami-0cf94b1c148cb4b81"
}

variable "key_name" {
  default = "terraform2"
}

variable "private_key" {
  default = "~/.ssh/terraform2.pem"
}
