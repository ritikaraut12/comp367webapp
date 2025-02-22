pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/ritikaraut12/comp367webapp.git
            }
        }
        /*
        stage('Initialize') {
            steps {
                script {
                    // REMOVE THIS STAGE: It's causing the error
                    bat 'mvn archetype:generate -DgroupId=com.example -DartifactId=COMP367_WebApp -DarchetypeArtifactId=maven-archetype-quickstart -DinteractiveMode=false'
                }
            }
        }
        */
        stage('Build') {
            steps {
                bat 'mvn clean package'
            }
        }
        stage('Test') {
            steps {
                bat 'mvn test'
            }
        }
        stage('Deploy') {
            steps {
                bat 'mvn jetty:run'
            }
        }
    }
}
