pipeline {

    agent any

    environment 
    {
        // Always Update ECRURL and ECRCRED with awskey
        
        VERSION = 'latest'
        PROJECT = 'jenkinsdemo'
        IMAGE = 'jenkinsdemo:latest'
        ECRURL = 'http://430664767574.dkr.ecr.us-east-1.amazonaws.com'
        ECRCRED = 'ecr:us-east-1:awskey'
        
        //SonarQubeScanner Set path in Jenkins
        scannerHome = tool 'SonarQubeScanner'
    }

    stages {

        stage('Build with Static Code Analysis : SonarQubeScanner')
        {

            steps
            {
                    echo "Build preparations with Static Code Analysis : SonarQubeScanner"
                    //withSonarQubeEnv('sonarqube') 
                        script {
                        //sh "${scannerHome}/bin/sonar-scanner"
                        //sh "/opt/sonarqube/sonar-scanner/bin/sonar-scanner"
                       // sh "/opt/sonarqube/sonar-scanner/bin/sonar-scanner -Dsonar.projectKey=jenkinsdemo -Dsonar.sources=. -Dsonar.host.url=http://3.6.92.155  -Dsonar.login=29013f58a46b678adff090e309c857a8d0afb9d5"
                    }
            
            }
        }

        stage('Docker build')
        {
            steps
            {
                script
                {
                    ///                    docker.build("$PROJECT")
                    docker.build('jenkinsdemo')
                    //sh "docker build --build-arg APP_NAME=receipts -t 430664767574.dkr.ecr.us-east-1.amazonaws.com/jenkinsdemo:latest -f ."
                }
            }
        }

        stage('Docker push')
        {
            steps
            {
                script
                {
// Push the Docker image to ECR
                    docker.withRegistry(ECRURL, ECRCRED)
                    {
                        docker.image('jenkinsdemo').push("latest")
//                        docker.image('jenkinsdemo').push("$currentBuild.number")
                    }
//                          docker.withRegistry('https://430664767574.dkr.ecr.us-east-1.amazonaws.com', 'ecr:us-east-1:awskey') {
//                           docker.image('jenkins/demo').push("$currentBuild.number")                    }
                }
            }
        }

    }
}

