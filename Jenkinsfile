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
    stage('Dfine MVN'){
      steps{
        def mvnhome = tool name: 'My_Maven', type: 'maven'
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
    }
  }
