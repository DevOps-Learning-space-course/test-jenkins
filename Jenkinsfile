def tag

node ('Slave'){

      stage('checkout') {

            git credentialsId: '', url: 'https://github.com/ZiyaadQasem/test-jenkins.git'
        }

      stage("test-build"){
                sh "mvn clean install"
        }

        stage("build image"){
                sh 'docker build -t salla-demo  .'
         }

       stage("push image"){
          withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: 'ziyaad-docker',
                          usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASS']]) {
                sh 'docker login -u $DOCKER_USERNAME -p $DOCKER_PASS'
                tag = sh(returnStdout:  true, script: "git tag --sort=-creatordate | head -n 1").trim()
                sh 'docker tag salla-demo $DOCKER_USERNAME/sa-demo:' + tag
                sh 'docker push $DOCKER_USERNAME/sa-demo:' + tag
           }
       }
      
      stage("release"){
                sh 'docker rm mydemo --force | true'
                sh 'docker run --name mydemo -p 8080:8080 -d salla-demo'
         }
}
