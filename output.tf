# Jenkins public ip
output "jenkins_public_ip" {
    value = aws_instance.jenkins-server.public_ip
}

# Jenkins private ip
output "jenkins_private_ip" {
    value = aws_instance.jenkins-server.private_ip
}

# Swagger app public ip
output "swagger_app_public_ip" {
    value = aws_instance.swagger-app.public_ip
}

# Swagger app private ip
output "swagger_app_private_ip" {
    value = aws_instance.swagger-app.private_ip
}

# Redis cluster address
output "elasticache_address" {
    //value = aws_instance.swagger-app.private_ip
    value = aws_elasticache_cluster.swagger_app_redis_cluster.cluster_address
}

# Redis cluster config endpoint
output "elasticache_config_endpoint" {
    value = aws_elasticache_cluster.swagger_app_redis_cluster.configuration_endpoint
}

# Redis cluster cache nodes
output "elastic_cache_nodes" {
    value = aws_elasticache_cluster.swagger_app_redis_cluster.cache_nodes
}
