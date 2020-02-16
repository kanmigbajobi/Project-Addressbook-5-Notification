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
            sh label: '', script: 'docker build -t project-addressbook-3 .'
        }
      }
    }
  }
