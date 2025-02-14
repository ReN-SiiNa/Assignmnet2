pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "flask-app:latest"
    }

    stages {
        stage('Checkout Code') {
            steps {
                git 'https://github.com/YourUsername/YourRepo.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh "docker build -t ${DOCKER_IMAGE} ."
                }
            }
        }

        stage('Run Tests') {
            steps {
                script {
                    sh "docker run --rm ${DOCKER_IMAGE} pytest tests/"
                }
            }
        }

        stage('Run Flask App') {
            steps {
                script {
                    sh "docker run -d -p 5000:5000 --name flask-app ${DOCKER_IMAGE}"
                }
            }
        }
    }

    post {
        always {
            sh "docker ps -a"
        }
    }
}
