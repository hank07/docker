pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials("dockerhub-creds")
        /*DOCKER_REGISTRY = "https://hub.docker.com/repository/docker/hank07"
        DOCKER_IMAGE_NAME = "MyFirstImage" */
    }

    stages {
        stage('SCM Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/hank07/docker.git'
            }
        }

        stage('Echo Credentials') {
            steps {
                echo "DOCKERHUB_CREDENTIALS: ${DOCKERHUB_CREDENTIALS}"
            }
        }
        

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t hank07/MyFirstImage:$BUILD_NUMBER .'
            }
        } 
		
        stage('Docker Login') {
            steps {
                echo 'Logging in to Docker Hub'
                sh "echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin"
                
                echo 'Login Successful'
            }
        }

        

        stage('Push Docker Image') {
            steps {
                sh 'docker push hank07/MyFirstImage:$BUILD_NUMBER
                }
            }
        }
    }

    post {
        success {
            echo 'Docker image built and pushed successfully!'
        }
    }
