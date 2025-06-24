@Library('jenkins-exercises-shared-library')
def UPDATED_VERSION


pipeline {
    agent any
    environment {
        BRANCH_NAME = 'main'
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
                    buildImage()
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
