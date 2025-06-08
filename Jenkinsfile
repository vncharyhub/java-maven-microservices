pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "product-service"
        DOCKER_TAG = "latest"
        REGISTRY_CREDENTIALS = 'dockerhub-creds'
    }

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/vncharyhub/java-maven-microservices'
            }
        }

        stage('Build') {
            steps {
                dir('product-service') {
                    sh 'mvn clean package -DskipTests'
                }
            }
        }

        stage('Docker Build & Push') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', REGISTRY_CREDENTIALS) {
                        def image = docker.build("${DOCKER_IMAGE}:${DOCKER_TAG}", "product-service")
                        image.push()
                    }
                }
            }
        }
    }
}

