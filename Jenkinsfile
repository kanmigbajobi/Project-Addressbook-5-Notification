node{
   stage('SCM Checkout'){
      tool name: 'My_Git', type: 'git'
      git credentialsId: 'GithubUserPass', url: 'https://github.com/kanmigbajobi/Project-Addressbook-2.git'
   }
   stage('Maven Package'){
      def mvnhome = tool name: 'My_Maven', type: 'maven'
      def mvnCMD = "${mvnhome}/bin/mvn"
      sh label: '', script: "${mvnCMD} clean package"
   }
    stage('Build Image') {
       sh label: '', script: 'docker build -t project-addressbook-2 .'
        }
   
   stage('Push Image') {
       withDockerRegistry(credentialsId: 'ecr:eu-west-2:AWSSecretKeysAndAccessKeys', url: 'https://807395240887.dkr.ecr.eu-west-2.amazonaws.com/test3') {
           sh label: '', script: 'docker tag test3:latest 807395240887.dkr.ecr.eu-west-2.amazonaws.com/project-addressbook-2:latest'
           sh label: '', script: 'docker push 807395240887.dkr.ecr.eu-west-2.amazonaws.com/project-addressbook-2:latest'
        }
   }
   stage('Update Service'){
      sh label: '', script: 'aws ecs update-service --service new-project-2  --force-new-deployment'
     } 
}
