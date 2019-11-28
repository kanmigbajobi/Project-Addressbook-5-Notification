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
        input message: 'Would you like to build the Image now? Click Continue to Continue', ok: 'Continue'
        sh label: '', script: 'docker build -t test3 .'
    }
   
   stage('Push Image') {
       withDockerRegistry(credentialsId: 'ecr:eu-west-2:AWSSecretKeysAndAccessKeys', url: 'https://807395240887.dkr.ecr.eu-west-2.amazonaws.com/test3') {
           sh label: '', script: 'docker tag test3:latest 807395240887.dkr.ecr.eu-west-2.amazonaws.com/test3:latest'
           sh label: '', script: 'docker push 807395240887.dkr.ecr.eu-west-2.amazonaws.com/test3:latest'
        }
   }
}
 
