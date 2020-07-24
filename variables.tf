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

variable "ec2-ami" {
  default     = "ami-032598fcc7e9d1c7a"
  description = "Amazon ami id"
}

variable "key_name" {
  default     = "terraform2"
  description = "Key name"
}

variable "private_key" {
  default     = "~/.ssh/terraform2.pem"
  description = "open door"
}
