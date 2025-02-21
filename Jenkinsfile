pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/ritikaraut12/comp367webapp.git'
            }
        }
        stage('Build') {
            steps {
                sh 'mvn clean package'
            }
        }
        stage('Deploy') {
            steps {
                echo "Deploying the application..."
            }
        }
    }
}

}
