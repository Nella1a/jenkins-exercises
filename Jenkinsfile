pipeline {
    agent any

    stages {
        stage('increment version'){
            steps {
                script {
                    echo 'incrementing app version'
                    // change directory
                    dir('app') {
                     sh 'git fetch'
                     sh 'git checkout $BRANCH_NAME'
                     CURRENT_VERSION=$(node -p "require('./package.json').version")
                     sh 'npm version minor --git-tag-version false'
                     env.UPDATED_VERSION=$(node -p "require('./package.json').version")
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
                    sh "docker build -t kanjamn/demo-app:jenkinsexercises-${UPDATED_VERSION} ."
                    sh 'echo $PASS | docker login -u $USER --password-stdin'
                    sh "docker push kanjamn/demo-app:jenkinsexercises-${UPDATED_VERSION}"
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
