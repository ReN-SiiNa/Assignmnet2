pipeline {
    agent any

    environment {
        IMAGE_NAME = "rensiina/flask-CICD:latest"
        CONTAINER_NAME = "flask-CICD"
        GIT_REPO = "https://github.com/ReN-SiiNa/Assignmnet2.git"
        GIT_CREDENTIALS_ID = "github"
        DOCKER_CREDENTIALS_ID = "docker"
    }

    stages {
        stage('Checkout Code') {
            steps {
                script {
                    checkout([$class: 'GitSCM',
                        branches: [[name: '*/main']], 
                        userRemoteConfigs: [[url: GIT_REPO, credentialsId: GIT_CREDENTIALS_ID]]
                    ])
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh "docker build -t ${IMAGE_NAME} ."
                }
            }
        }

        stage('Run Tests') {
            steps {
                script {
                    sh "docker run --rm ${IMAGE_NAME} pytest tests/"
                }
            }
        }

        stage('Push Image to Docker Hub') {
            steps {
                script {
                    withDockerRegistry([credentialsId: DOCKER_CREDENTIALS_ID]) {
                        sh "docker tag ${IMAGE_NAME} rensiina/flask-CICD:latest"
                        sh "docker push rensiina/flask-CICD:latest"
                    }
                }
            }
        }

        stage('Stop & Remove Existing Container') {
            steps {
                script {
                    sh """
                    docker stop ${CONTAINER_NAME} || true
                    docker rm ${CONTAINER_NAME} || true
                    """
                }
            }
        }

        stage('Deploy Application') {
            steps {
                script {
                    sh "docker run -d -p 5000:5000 --name ${CONTAINER_NAME} ${IMAGE_NAME}"
                }
            }
        }
    }

    post {
        always {
            script {
                sh "docker ps -a"
            }
        }

        cleanup {
            script {
                sh "docker rmi -f ${IMAGE_NAME} || true"
            }
        }
    }
}
