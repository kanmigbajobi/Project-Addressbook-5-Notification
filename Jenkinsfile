properties([parameters([choice(choices: ['dev', 'master'], description: '', name: 'branch')])])
pipeline {
    agent any 
  stages {
    stage('SCM Checkout'){
      steps{
        tool name: 'My_Git', type: 'git'
        git credentialsId: 'GithubUserPass', url: 'https://github.com/kanmigbajobi/Project-Addressbook-2.git'
        
    }
  } 

    stage('Maven Package'){
     when {
  branch 'master'
     }
      steps{
         sh label: '', script: "mvn clean package"
        } 
      }
    stage('Build Image') {
      steps{
            sh label: '', script: 'docker build -t project-addressbook-declarative-4 .'
        }
      }
      stage('Push Image') {
        steps{
           withDockerRegistry(credentialsId: 'ecr:eu-west-2:AWSSecretKeysAndAccessKeys', url: 'https://807395240887.dkr.ecr.eu-west-2.amazonaws.com/project-addressbook-declaractive-4') {
              sh label: '', script: 'docker tag project-addressbook-2 807395240887.dkr.ecr.eu-west-2.amazonaws.com/project-addressbook-declaractive-4'
              sh label: '', script: 'docker push 807395240887.dkr.ecr.eu-west-2.amazonaws.com/project-addressbook-declaractive-4'
        }
      }
     }
    }
  }
