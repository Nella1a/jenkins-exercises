pipeline {
    agent any

    stages {
        stage('increment version'){
            steps {
                script {
                    echo 'incrementing app version'
                }
            }
        }

        stage("run test") {
            steps {
                script {
                    echo "running tests"
                    sh 'npm run test'
                }
            }
        }
        stage("build app") {
            steps {
                script {
                    echo "building the application"
                }
            }
        }
        stage("build image") {
            steps {
                script {
                    echo "building the docker image"
                    withCredentials([usernamePassword(credentialsId: 'docker-hub-cred', passwordVariable: 'PASS', usernameVariable: 'USER')]) {
                    sh "docker build -t kanjamn/demo-app:jenkinsexercises-1.0 ."
                    sh 'echo $PASS | docker login -u $USER --password-stdin'
                    sh "docker push kanjamn/demo-app:jenkinsexercises-1.0"
                    }
                }
            }
        }

        stage("deploy") {
            steps {
                script {
                    echo "deploying the application ..."
                }
            }
        }
    }
}
