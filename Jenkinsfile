pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials("dockerhub-creds")
        /*DOCKER_REGISTRY = "https://hub.docker.com/repository/docker/hank07"
        DOCKER_IMAGE_NAME = "MyFirstImage" */
    }

    stages {
        /* Uncomment the following block if you need to clone a Git repository
        stage('SCM Checkout') {
            steps {
                git branch: 'master', url: 'https://github.com/ashish/testweb.git'
            }
        }
        */
        stage('List Credentials') {
            steps {
                script {
                    def credentialsList = credentials('') // Empty ID means list all credentials
                    echo "Available Credentials:\n${credentialsList.join('\n')}"
                }
            }
        }
        stage('Echo Credentials') {
            steps {
                echo "DOCKERHUB_CREDENTIALS: ${DOCKERHUB_CREDENTIALS}"
            }
        }

        stage('Docker Login') {
            steps {
                echo 'Logging in to Docker Hub'
                sh "echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin"
                
                echo 'Login Successful'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t https://hub.docker.com/repositories/hank07/MyFirstImage:$BUILD_NUMBER'
            }
        }

        stage('Push Docker Image') {
            steps {
                sh 'docker push https://hub.docker.com/repositories/hank07/MyFirstImage:$BUILD_NUMBER'
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
