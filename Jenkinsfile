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
                    echo 'incrementing app version'
                    // change directory
                    dir('app') {
                     sh 'git fetch'
                    def CURRENT_VERSION = sh(
                        script: "node -p \"require('./package.json').version\"",
                        returnStdout: true
                    ).trim()
                     sh 'npm version minor --git-tag-version false'

                    UPDATED_VERSION = sh(
                        script: "node -p \"require('./package.json').version\"",
                        returnStdout: true
                    ).trim()

                     sh 'git add package.json'
                     sh '[ -f ./package-lock.json ] && git add package-lock.json'
                    }

                }
            }
        }

        stage("run test") {
            steps {
                script {
                    echo "running tests"
                    // change directory
                    dir('app') {
                     sh 'npm install'
                     sh 'npm run test'
                    }
                }
            }
        }
        stage("build image") {
            steps {
                script {
                    echo "building the docker image"
                    withCredentials([usernamePassword(credentialsId: 'docker-hub-cred', passwordVariable: 'PASS', usernameVariable: 'USER')]) {
                    sh "docker build -t kanjamn/demo-app:jenkinsexercises-${UPDATED_VERSION} ."
                    sh 'echo $PASS | docker login -u $USER --password-stdin'
                    sh "docker push kanjamn/demo-app:jenkinsexercises-${UPDATED_VERSION}"
                    }
                }
            }
        }

        stage ("commit version update"){
            steps {
                script {
                      echo 'commit to changes to github'
                      withCredentials([usernamePassword(credentialsId: 'github-cred-two', passwordVariable: 'PASS', usernameVariable: 'USER')]) {
                      sh 'git config user.name "jenkins"'
                      sh 'git config user.email "jenkins@example.com"'

                      sh 'git status'
                      sh 'git branch'
                      sh 'git config --list'

                      sh 'git remote set-url origin https://$USER:$PASS@github.com/Nella1a/jenkins-exercises.git'
                      sh 'git add .'
                      sh 'git commit -m "ci: version bump"'
                      sh 'git push origin HEAD:main'
                    }
                }
            }
        }
    }
}
