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
  branch 'dev'
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
      stage('Push Image to Staging') {
        when {
      branch 'dev'
        }
        steps{
           withDockerRegistry(credentialsId: 'ecr:eu-west-2:AWSSecretKeysAndAccessKeys', url: 'https://807395240887.dkr.ecr.eu-west-2.amazonaws.com/project-addressbook-declaractive-4') {
              sh label: '', script: 'docker tag project-addressbook-2 807395240887.dkr.ecr.eu-west-2.amazonaws.com/project-addressbook-declaractive-4'
              sh label: '', script: 'docker push 807395240887.dkr.ecr.eu-west-2.amazonaws.com/project-addressbook-declaractive-4'
        }
      }
     }
     stage('Push Image to Prod') {
        when {
      branch 'dev'
        }
        steps{
           withCredentials([[
	   $class: 'AmazonWebServicesCredentialsBinding', 
           accessKeyVariable: 'AWS_ACCESS_KEY_ID', 
           credentialsId: 'AWSSecretKeysAndAccessKeys', 
           secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
           ]]) {
                sh label: '', script: 'docker tag project-addressbook-declarative-4-prod:latest 807395240887.dkr.ecr.eu-west-3.amazonaws.com/project-addressbook-declarative-4-prod:latest'
		sh label: '', script: 'docker push 807395240887.dkr.ecr.eu-west-3.amazonaws.com/project-addressbook-declarative-4-prod:latest'
         }
       }
     }   
    }
  }
