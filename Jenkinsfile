@Library('jenkins-exercises-shared-library')

pipeline {
    agent any
    environment {
        UPDATED_VERSION = ''
    }


    stages {
        stage('increment version'){
            steps {
                script {
                    incrementVersion UPDATED_VERSION
                }
            }
        }

        stage("run test") {
            steps {
                script {
                    runTest()
                }
            }
        }
        stage("build image") {
            steps {
                script {
                    buildImage UPDATED_VERSION
                }
            }
        }

        stage ("commit version update"){
            steps {
                script {
                    gitCommit()
                }
            }
        }
    }
}
