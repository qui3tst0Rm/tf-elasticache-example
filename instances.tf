# Create ec2-instance for jenkins server
resource "aws_instance" "jenkins-server" {
  ami = var.ec2-ami
  instance_type = "t2.micro"
  key_name = var.key_name
  subnet_id = aws_subnet.public_1.id
  vpc_security_group_ids = local.sg1

    tags = {
    Name = "jenkins-server"
  }

  connection {
    type = "ssh"
    user = "ec2-user"
    private_key = file(var.private_key)
    host = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo yum install -y git",
      "sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key",
      "sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo",
      "sudo yum upgrade -y",
      "sudo yum install -y java-1.8.0-openjdk-devel",
      "sudo yum install -y jq",
      "sudo yum install -y maven",
      "sudo echo 'export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.252.b09-2.amzn2.0.1.x86_64' >> ~/.bashrc",
      "sudo echo 'export M2_HOME=/usr/share/maven' >> ~/.bashrc",
      "sudo echo 'export MAVEN_HOME=/usr/share/maven' >> ~/.bashrc",
      "sudo echo 'export PATH=$MAVEN_HOME/bin:$PATH' >> ~/.bashrc",
      "sudo echo 'export PATH=$JAVA_HOME/bin:$PATH' >> ~/.bashrc",
      "sudo yum install -y jenkins",
      "wget https://releases.hashicorp.com/packer/1.6.0/packer_1.6.0_linux_amd64.zip",
      "sudo unzip packer_1.6.0_linux_amd64.zip -d /usr/bin",
      "sudo echo 'export PATH=/usr/bin/packer:$PATH' >> ~/.bashrc",
      "wget https://releases.hashicorp.com/terraform/0.12.26/terraform_0.12.26_linux_amd64.zip",
      "sudo unzip terraform_0.12.26_linux_amd64.zip -d /usr/bin",
      "sudo echo 'export PATH=/usr/bin/terraform:$PATH' >> ~/.bashrc",
      "source .bashrc",
      "sudo mkdir /var/lib/jenkins/env_vars",
      "sudo usermod --shell /bin/bash jenkins",
      "sudo usermod -aG wheel jenkins",
      "sudo systemctl enable jenkins",
      "sudo systemctl start jenkins"
    ]
  }
}

# Create ec2-instance for swagger-app

resource "aws_instance" "swagger-app" {
  ami = var.ec2-ami
  instance_type = "t2.micro"
  key_name = var.key_name
  subnet_id = aws_subnet.public_2.id
  vpc_security_group_ids = local.sg2

    tags = {
    Name = "swagger-app"
  }

  connection {
    type = "ssh"
    user = "ec2-user"
    private_key = file(var.private_key)
    host = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo yum install -y java-1.8.0-openjdk-devel",
      "sudo yum install -y maven",
      "sudo echo 'export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.252.b09-2.amzn2.0.1.x86_64' >> ~/.bashrc",
      "sudo echo 'export M2_HOME=/usr/share/maven' >> ~/.bashrc",
      "sudo echo 'export MAVEN_HOME=/usr/share/maven' >> ~/.bashrc",
      "sudo echo 'export PATH=$MAVEN_HOME/bin:$PATH' >> ~/.bashrc",
      "sudo echo 'export PATH=$JAVA_HOME/bin:$PATH' >> ~/.bashrc",
      "source .bashrc",
      "sudo mkdir /var/lib/jenkins",
      "sudo useradd -d /var/lib/jenkins jenkins",
      "sudo mkdir /var/lib/jenkins/env_vars",
      "sudo chown jenkins:jenkins /var/lib/jenkins/env_vars",
      "sudo usermod --shell /bin/bash jenkins",
      "sudo usermod -aG wheel jenkins",
      "sudo yum install -y gcc",
      "wget http://download.redis.io/redis-stable.tar.gz",
      "tar xzf redis-stable.tar.gz"
     // "cd redis-stable && make distclean && make"

    ]
  }
}

resource "aws_elasticache_subnet_group" "redis-cluster-subnet" {
  name = "elasticache-private-subnet"
  subnet_ids = [aws_subnet.private_1.id]
}

resource "aws_elasticache_security_group" "redis-cluster-sec-gp" {
  name = "elasticache-security-group"
  security_group_names = [aws_security_group.group_3.name]
  //security_group_ids = aws_security_group.group_3.id
  //security_group_names = ["sec_group_3"]

}

##### Redis Cluster with cluster mode disabled #####
resource "aws_elasticache_cluster" "swagger_app_redis_cluster" {
  cluster_id = "swagger-app-redis-cluster"
  engine = "redis"
  node_type = "cache.t2.micro"
  num_cache_nodes = 1
  parameter_group_name = "default.redis5.0"
  engine_version = "5.0.6"
  port = 6379
  subnet_group_name = "elasticache-private-subnet"
  //subnet_group_name = [aws_elasticache_subnet_group.redis-cluster-subnet.name]
  security_group_names = [aws_elasticache_security_group.redis-cluster-sec-gp.name]
}


##### Redis Cluster with cluster mode enabled (cluster mode enabled requires a replication group) #####




##### Elasticache replication group #####

//src/redis-cli -c -h ENDPOINT.COM -p 6379




