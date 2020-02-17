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
    stage('Build Dev Image ') {
     when {
    branch 'dev'
      }
       steps{
            sh label: '', script: '$(aws ecr get-login --no-include-email --region eu-west-2)'
            sh label: '', script: 'docker build -t project-addressbook-declarative-4-dev .'
        }
      }
     
     stage('Build Prod Image ') {
     when {
    branch 'master'
       }
       steps{
            sh label: '', script: '$(aws ecr get-login --no-include-email --region eu-west-3)'
            sh label: '', script: 'docker build -t project-addressbook-declarative-4-prod .'
        }
      }

     
     stage('Push Image to Staging') {
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

              sh label: '', script: 'docker tag project-addressbook-declarative-4-dev 807395240887.dkr.ecr.eu-west-2.amazonaws.com/project-addressbook-declarative-4-dev'
              sh label: '', script: 'docker push 807395240887.dkr.ecr.eu-west-2.amazonaws.com/project-addressbook-declarative-4-dev'
        }
      }
     }

     stage ('Gateway to Prod') {
        when { 
     branch 'master'
           }
        steps{
           input message: 'You are about to deploy to Production, Do You want to carry on?', ok: 'Yes', parameters: [string(defaultValue: '', description: 'You will be deploying to Production', name: 'Aceptance', trim: true)]
     }
   }
     
     stage('Push Image to Prod') {
        when {
      branch 'master'
        }
        steps{
           withCredentials([[
	   $class: 'AmazonWebServicesCredentialsBinding', 
           accessKeyVariable: 'AWS_ACCESS_KEY_ID', 
           credentialsId: 'AWSSecretKeysAndAccessKeys', 
           secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
           ]]) {
                sh label: '', script: 'docker tag project-addressbook-declarative-4-prod 807395240887.dkr.ecr.eu-west-3.amazonaws.com/project-addressbook-declarative-4-prod'
		sh label: '', script: 'docker push 807395240887.dkr.ecr.eu-west-3.amazonaws.com/project-addressbook-declarative-4-prod'
           } 
         }
       }
      stage('Update Service'){
       when {
         branch 'dev'
          }
           withCredentials([[
           $class: 'AmazonWebServicesCredentialsBinding',
           accessKeyVariable: 'AWS_ACCESS_KEY_ID', 
           credentialsId: 'AWSSecretKeysAndAccessKeys',
           secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
           ]]) {
               sh label: '', script: 'aws ecs update-service --cluster Friday  --service Friday   --force-new-deployment --region eu-west-2'
       }       
    }
    
    stage('Update Service'){
       when {
         branch 'master'
          }
           withCredentials([[
           $class: 'AmazonWebServicesCredentialsBinding',
           accessKeyVariable: 'AWS_ACCESS_KEY_ID', 
           credentialsId: 'AWSSecretKeysAndAccessKeys',
           secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
           ]]) {
               sh label: '', script: 'aws ecs update-service --cluster Friday  --service Friday   --force-new-deployment --region eu-west-3'
       }       
    }


     }   
    }
 }
 
