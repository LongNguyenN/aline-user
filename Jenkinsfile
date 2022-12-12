pipeline {
    agent any
    tools {
        // Install the Maven version configured as "M3" and add it to the path.
        maven "M3"
    }
    environment {
        TAG = "alpha"
    }
    stages {
        stage('Build') {
            steps {
                echo 'Building..'
				        sh "mvn clean package -DskipTests"
            }
        }
        stage('Test') {
            steps {
                echo 'Testing..'
                withCredentials([string(credentialsId: 'sonarqube', variable: 'SONAR_TOKEN')]) {
                    sh "mvn clean verify sonar:sonar"
                }
            }
        }
        stage('Docker') {
            steps {
                echo 'Building image with docker....'
                sh "docker build -t ln/user ."
            }
        }
        stage('Deploy') {
            steps {
                echo 'Pushing to ECR....'
                withCredentials([string(credentialsId: 'amazon-id', variable: 'AMAZON_ID')]) {
                    script {
                        docker.withRegistry("https://${AMAZON_ID}.dkr.ecr.us-east-1.amazonaws.com", 'ecr:us-east-1:ln-aws-creds') {
                            docker.image('ln/user').push("$TAG")
                        }
                    }
                }
            }
        }
    }
}
