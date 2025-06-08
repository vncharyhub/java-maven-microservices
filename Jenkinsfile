pipeline {
    agent any

    environment {
        DOCKER_HUB_CREDENTIALS = credentials('dockerhub-creds')
        DOCKER_HUB_USER = "${DOCKER_HUB_CREDENTIALS_USR}"
        VERSION = "v1"
    }

    parameters {
        choice(name: 'SERVICE_NAME', choices: ['product-service', 'order-service', 'api-gateway', 'discovery-server'], description: 'Select the microservice to build and push')
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build with Maven') {
            steps {
                dir("${params.SERVICE_NAME}") {
                    sh 'mvn clean package -DskipTests'
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                dir("${params.SERVICE_NAME}") {
                    script {
                        def imageName = "${DOCKER_HUB_USER}/${params.SERVICE_NAME}:${VERSION}"
                        sh "docker build -t ${imageName} ."
                    }
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    def imageName = "${DOCKER_HUB_USER}/${params.SERVICE_NAME}:${VERSION}"
                    sh "echo ${DOCKER_HUB_CREDENTIALS_PSW} | docker login -u ${DOCKER_HUB_CREDENTIALS_USR} --password-stdin"
                    sh "docker push ${imageName}"
                }
            }
        }
    }

    post {
        success {
            echo "✅ Successfully built and pushed Docker image for ${params.SERVICE_NAME}:${VERSION}"
        }
        failure {
            echo "❌ Build failed for ${params.SERVICE_NAME}"
        }
    }
}
