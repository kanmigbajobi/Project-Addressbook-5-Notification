node{
   stage('SCM Checkout'){
      tool name: 'My_Git', type: 'git'
      git credentialsId: 'GithubUserPass', url: 'https://github.com/kanmigbajobi/my-app.git'
   }
   stage('Maven Package'){
      def mvnhome = tool name: 'My_Maven', type: 'maven'
      def mvnCMD = "${mvnhome}/bin/mvn"
      sh label: '', script: "${mvnCMD} clean package"
   }
    stage('Build Image') {
       sh label: '', script: 'docker build -t test3 .'
        }
   stage('Login to ECR'){
       sh label: '', script: '$(aws ecr get-login --no-include-email --region eu-west-2)'
   }
   stage('Push Image') {
           sh label: '', script: 'docker tag test3:latest 807395240887.dkr.ecr.eu-west-2.amazonaws.com/test3:latest'
           sh label: '', script: 'docker push 807395240887.dkr.ecr.eu-west-2.amazonaws.com/test3:latest'
        }
   }
}
