pipeline {
    agent any

    stages {

        stage('Checkout') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/PillaiSathya/aws-enterprise-devops-project.git'
            }
        }

        stage('Test') {
            steps {
                echo 'GitHub repository checked out successfully!'
            }
        }

        stage('Docker Build') {
            steps {
                sh 'docker build -t aws-enterprise-devops:jenkins .'
            }
        }
    }
}
