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
       sh label: '', script: 'docker build -t project-addressbook-2-${BUILD_NUMBER}:${BUILD_NUMBER} .'
        }
   
   stage('Push Image') {
       withDockerRegistry(credentialsId: 'ecr:eu-west-2:AWSSecretKeysAndAccessKeys', url: 'https://807395240887.dkr.ecr.eu-west-2.amazonaws.com/project-addressbook-2') {
           sh label: '', script: 'docker tag project-addressbook-2-${BUILD_NUMBER}:${BUILD_NUMBER} 807395240887.dkr.ecr.eu-west-2.amazonaws.com/project-addressbook-2-${BUILD_NUMBER}:${BUILD_NUMBER}'
           sh label: '', script: 'docker push 807395240887.dkr.ecr.eu-west-2.amazonaws.com/project-addressbook-2-${BUILD_NUMBER}:${BUILD_NUMBER}'
        }
   }
   stage('Update Service'){
      withCredentials([[
      $class: 'AmazonWebServicesCredentialsBinding', 
      accessKeyVariable: 'AWS_ACCESS_KEY_ID', 
      credentialsId: 'AWSSecretKeysAndAccessKeys', 
      secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
      ]]) {
          sh label: '', script: 'aws ecs update-service --cluster Friday  --service Friday   --force-new-deployment --region eu-west-2'
     } 
  }
}
