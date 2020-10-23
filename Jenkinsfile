pipeline{
    agent any
        tools {
            ant 'ANT'
        }
        environment {
            DOCKER_TAG = getVersion()
        }
    stages{
        stage('Git Clone'){
            steps{
                git 'https://github.com/pavan6001/javademo.git'
            }
        }
        
        stage('Ant Build'){
            steps{
                sh 'ant clean war'
            }
        }
        
        stage('Docker Build'){
            steps{
                sh 'docker build -t pavan6001/javaant:${DOCKER_TAG} .'
            }
        }
        
        stage('Docker Push'){
            steps{
                withCredentials([string(credentialsId: 'Docker_Hub', variable: 'DockerHubPwd')]) {
                    sh 'docker login -u pavan6001 -p ${DockerHubPwd}'
                }
                sh 'docker push pavan6001/javaant:${DOCKER_TAG}'
            }
        }
        
        stage('Docker Deploy'){
            steps{
                ansiblePlaybook credentialsId: 'Dev-Server', disableHostKeyChecking: true,extras: "-e 'DOCKER_TAG=${DOCKER_TAG}", installation: 'Ansible', inventory: 'dev.inv', playbook: 'docker-deploy.yml'
            }
        }
    }
}

def getVersion(){
    def CommitHash = sh returnStdout: true, script: 'git rev-parse --short HEAD'
    return CommitHash
}
