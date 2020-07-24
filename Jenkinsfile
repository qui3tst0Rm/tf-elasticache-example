pipeline{
    agent any

    environment {
            AWS_ACCESS_KEY_ID     = credentials ('AWS_ACCESS_KEY_ID')
            AWS_SECRET_ACCESS_KEY = credentials ('AWS_SECRET_ACCESS_KEY')
    }

    stages {
        stage ('scm checkout') {
            steps {
	            echo 'retrieving code form scm'
                git 'https://github.com/qui3tst0Rm/tf-elasticache-example.git'
	            echo 'code retrivial from scm complete'
            }
        }

        stage ('initialize tf') {
            steps {
	            echo 'initializing working directory'
                sh 'terraform init'            
	            echo 'initialization complete'
            }
        }

        stage ('validate tf'){
            steps {
	            echo 'validating terraform config files'
                sh 'terraform validate'
	            echo 'validation success'
            }
        }

        stage ('plan tf') {
            steps {
	            echo 'runnign terraform plan'
                sh 'terraform plan'
	            echo 'planning complete'
            }
        }

        stage ('apply tf') {
            steps {
	            echo 'applying terraform config to environment' 
                sh 'terraform apply -auto-approve'
	            echo 'deployment complete'
            }
        }

        stage ('write-file') {
            steps {
                script {
                    writeFile(file:'/var/lib/jenkins/env_vars/Swagger_Private_ip.txt', text: 'TBC')
                    writeFile(file:'/var/lib/jenkins/env_vars/Elasticache_Address.txt', text: 'TBC')
                    writeFile(file:'/var/lib/jenkins/env_vars/Elacticache_Config_Endpoint.txt', text: 'TBC')
                    writeFile(file:'/var/lib/jenkins/env_vars/Elasticache_Nodes.txt', text: 'TBC')                 
                }
                
                sh '''
                sudo chown jenkins:jenkins /var/lib/jenkins/env_vars/Swagger_Private_ip.txt
                sudo chmod 600 /var/lib/jenkins/env_vars/Swagger_Private_ip.txt
                sudo chown jenkins:jenkins /var/lib/jenkins/env_vars/Elasticache_Address.txt
                sudo chmod 600 /var/lib/jenkins/env_vars/Elasticache_Address.txt
                sudo chown jenkins:jenkins /var/lib/jenkins/env_vars/Elacticache_Config_Endpoint.txt
                sudo chmod 600 /var/lib/jenkins/env_vars/Elacticache_Config_Endpoint.txt
                sudo chown jenkins:jenkins /var/lib/jenkins/env_vars/Elasticache_Nodes.txt
                sudo chmod 600 /var/lib/jenkins/env_vars/Elasticache_Nodes.txt
                '''
            }
        }

        stage("set-instance-ips") {
            steps {
                sh '''
                terraform output -json swagger_app_private_ip > /var/lib/jenkins/env_vars/Swagger_Private_ip.txt
                terraform output -json elasticache_address > /var/lib/jenkins/env_vars/Elasticache_Address.txt
                terraform output -json elasticache_config_endpoint > /var/lib/jenkins/env_vars/Elacticache_Config_Endpoint.txt
                terraform output -json elastic_cache_nodes > /var/lib/jenkins/env_vars/Elasticache_Nodes.txt
                '''
                /*terraform output proxy_server_private_ip > /var/lib/jenkins/env_vars/Nginx_Box_ip.txt
                terraform output -json app_server_private_ips3 | jq '."Blue-Box"' --raw-output > /var/lib/jenkins/env_vars/Blue_Box_ip.txt                
                terraform output -json app_server_private_ips3 | jq '."Red-Box"' --raw-output > /var/lib/jenkins/env_vars/Red_Box_ip.txt*/
            }
        }







    }    

}