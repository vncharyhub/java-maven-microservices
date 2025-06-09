pipeline {
  agent any

  environment {
    AWS = credentials('aws-creds') // contains AWS_USR and AWS_PSW
    DOCKER = credentials('dockerhub-creds')
    PEM_S3 = 's3://java-maven-devops-project/devops-automation-ubuntu.pem'
    VERSION = "v1"
  }

  stages {
    stage('Checkout') {
      steps {
        checkout scm
      }
    }

    stage('Terraform & EKS Setup') {
      environment {
        AWS_ACCESS_KEY_ID = "${AWS_USR}"
        AWS_SECRET_ACCESS_KEY = "${AWS_PSW}"
      }
      steps {
        script {
          // Download PEM file
          sh 'aws s3 cp ${PEM_S3} ./jenkins.pem && chmod 600 jenkins.pem'

          // Get IAM User ARN from current credentials
          def jenkinsArn = sh(script: "aws iam get-user --query 'User.Arn' --output text", returnStdout: true).trim()
          echo "Extracted IAM User ARN: ${jenkinsArn}"

          // Run Terraform with the ARN passed as a variable
          dir('terraform') {
            sh 'terraform init'
            sh """
              terraform apply -auto-approve \
                -var='jenkins_ssh_iam_user_arn=${jenkinsArn}'
            """

            sh '''
              aws eks update-kubeconfig \
                --name $(terraform output -raw cluster_name) \
                --region us-east-1
            '''
          }
        }
      }
    }

    stage('Build & Push Docker Images') {
      matrix {
        axes {
          axis {
            name 'SERVICE'
            values 'api-gateway', 'discovery-server', 'product-service', 'order-service'
          }
        }
        stages {
          stage('Build & Push') {
            steps {
              dir("${SERVICE}") {
                sh 'mvn clean package -DskipTests'
                sh "docker build -t ${DOCKER_USR}/${SERVICE}:${VERSION} ."
                sh "echo ${DOCKER_PSW} | docker login -u ${DOCKER_USR} --password-stdin"
                sh "docker push ${DOCKER_USR}/${SERVICE}:${VERSION}"
              }
            }
          }
        }
      }
    }

    stage('Deploy to EKS') {
      matrix {
        axes {
          axis {
            name 'SERVICE'
            values 'api-gateway', 'discovery-server', 'product-service', 'order-service'
          }
        }
        stages {
          stage('Apply K8s Manifests') {
            steps {
              script {
                def deployFile = "k8s-manifests/${SERVICE}-deployment.yaml"
                def serviceFile = "k8s-manifests/${SERVICE}-service.yaml"

                sh """
                  sed -i 's|DOCKER_USER|${DOCKER_USR}|g' ${deployFile}
                  sed -i 's|VERSION|${VERSION}|g' ${deployFile}
                  kubectl apply -f ${deployFile}
                  kubectl apply -f ${serviceFile}
                """
              }
            }
          }
        }
      }
    }
  }

  post {
    success {
      echo "✅ Successfully deployed all microservices to EKS"
    }
    failure {
      echo "❌ Pipeline execution failed"
    }
  }
}
