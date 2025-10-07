pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "docker-app-name"
        REGISTRY_CREDENTIALS = 'docker-hub-credentials-id'

    }

    triggers {
        githubPush()
    }
	
	stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/sumitradalai/IBM-UseCase.git', branch: 'feature/usecase_1'
            }
        }
		
		
        stage('Build') {
            steps {
                 sh 'mvn clean package -DskipTests=false'
            }
        }
		
		
        stage('Test') {
            steps {
                sh 'mvn test'
            }
        }

        stage('Docker Build') {
            steps {
                sh 'docker build -t $DOCKER_IMAGE:$BUILD_NUMBER .'
            }
        }

        stage('Push to Registry') {
            steps {
				docker.withRegistry('https://registry.hub.docker.com'){
                    sh 'docker push $DOCKER_IMAGE:$BUILD_NUMBER'
				}
                }
            }
        }
		
		stage('Deploy to Staging') {
            steps {
                sh """
				    export KUBECONFIG=$KUBECONFIG
					kubectl apply -f deployment.yaml
				  """
                }
            }
        }
		
	post {
        always {
            // Clean up workspace to save disk space
            cleanWs()
        }
        success {
            echo 'Pipeline finished successfully!'
        }
        failure {
            mail to: 'sumitradalai882@gmail.com',
                 subject: "Build Failed: #${env.BUILD_NUMBER}",
                 body: "Check Jenkins for details: ${env.BUILD_URL}"
        }
    }
}

