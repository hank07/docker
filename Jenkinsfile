pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials("dockerhub-creds")
        DOCKER_REGISTRY = "https://hub.docker.com/repository/docker/hank07"
        DOCKER_IMAGE_NAME = "MyFirstImage"
    }

    stages {
        /* Uncomment the following block if you need to clone a Git repository
        stage('SCM Checkout') {
            steps {
                git branch: 'master', url: 'https://github.com/ashish/testweb.git'
            }
        }
        */

         stage('Echo Credentials') {
            steps {
                echo "DOCKERHUB_CREDENTIALS: ${DOCKERHUB_CREDENTIALS}"
            }
        }

        stage('Docker Login') {
            steps {
                echo 'Logging in to Docker Hub'
                sh "echo \${DOCKERHUB_CREDENTIALS} | docker login -u \${DOCKERHUB_CREDENTIALS_USR} --password-stdin docker.io"
                echo 'Login Successful'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build("${DOCKER_REGISTRY}/${DOCKER_IMAGE_NAME}:${env.BUILD_NUMBER}")
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry("${DOCKER_REGISTRY}", 'your-docker-credentials') {
                        dockerImage.push()
                    }
                }
            }
        }
    }

    post {
        success {
            echo 'Docker image built and pushed successfully!'
        }
    }
}
