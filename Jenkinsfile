node {
        env.JAVA_HOME = tool name: 'My_Java', type: 'jdk'
        def mvnHome = tool name: 'My_Maven', type: 'maven'
        def mvnCMD = "${mvnHome}/bin/mvn"
	
    stage("SCM checkout"){
       git  'https://github.com/kanmigbajobi/Project-Addressbook.git'
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
 
