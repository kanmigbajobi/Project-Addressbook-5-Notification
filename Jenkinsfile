#The first line is the node block; This tells which node you want to carry out your buildd
#Work.


node {
        env.JAVA_HOME = tool name: 'My_Java', type: 'jdk'
        def mvnHome = tool name: 'My_maven', type: 'maven'
        def mvnCMD = "${mvnHome}/bin/mvn"
#Go to  the pipeline syntax, find and click "git"        
    stage("SCM checkout"){
       git  'https://github.com/kanmigbajobi/devops-1.git'
    }

    stage("validate"){
        script{
            echo "validating now"
            sh "${mvnCMD} validate"
        }
    }
    
    stage("compile"){
        script{
            echo "compling the job now"
            sh "${mvnCMD} compile"
        }
        
    }
    stage("test"){
        script{
            echo "testing the job now"
             sh "${mvnCMD} test"
        }    
    }
   stage("package"){
       script {
           echo "packaging the Job now"
	   sh "${mvnCMD} package"
       }
       
   }
   stage("verify"){
       script {
           echo "verifying the job now"
            sh "${mvnCMD} verify"
       }

   }
}
 
