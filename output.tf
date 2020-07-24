# Jenkins public ip
output "jenkins_public_ip" {
  value = aws_instance.jenkins-server.public_ip
}

# Jenkins private ip
output "jenkins_private_ip" {
  value = aws_instance.jenkins-server.private_ip
}
