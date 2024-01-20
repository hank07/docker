pipeline {
    agent any

   environment { // getting stored credentials
       DOCKERHUB_CREDENTIALS = credentials('dockerhub-creds')
       DOCKER_REGISTRY = 'https://hub.docker.com/repository/docker/hank07'
       DOCKER_IMAGE_NAME = 'MyFirstImage'
   }

   /*stages { // to clone repo. Enable this section if you are using inline jenkins script
       stage('SCM Checkout') {
           steps {
               git branch: 'master', url: 'https://github.com/ashish/testweb.git'
           //sh 'whoami'
           }
       }
    */

       stage('Docker Login') {
           steps {
               echo 'Logon in to docker hub'
               sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin docker.io'
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
                    docker.withRegistry('${DOCKER_REGISTRY}', 'your-docker-credentials') {
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
