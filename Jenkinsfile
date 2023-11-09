pipeline {
    agent any

    environment {
        PATH = "/usr/local/bin:$PATH"
        DOCKER_IMAGE = "hello-world-node-app"
        DOCKERHUB_CREDENTIALS = 'docker-account' // The ID of your Docker Hub credentials in Jenkins
        KUBECONFIG_CREDENTIALS = 'minikube-kubeconfig' // The ID of your kubeconfig file credentials in Jenkins
    }

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/dalideco/tp3-Kubernetes'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sleep(10800)

                    def imageNameWithTag = "dalideco/${env.DOCKER_IMAGE}:latest"
                    docker.build(imageNameWithTag)
                }
            }
        }

        stage('Push to DockerHub') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', DOCKERHUB_CREDENTIALS) {
                        def image = docker.image("dalideco/${env.DOCKER_IMAGE}:latest")
                        image.push()
                    }
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                script {
                    withCredentials([file(credentialsId: KUBECONFIG_CREDENTIALS, variable: 'KUBECONFIG')]) {
                        sh 'kubectl apply -f deployment.yaml'
                        sh 'kubectl apply -f service.yaml'
                        sh 'kubectl apply -f loadbalancer-service.yaml'
                    }
                }
            }
        }
    }
}
