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
                  UPDATED_VERSION = incrementVersion()
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
