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
            
            scannerHome = tool 'SonarQubeScanner'
        }

        stages {

            stage('Build preparations')
            {

                steps
                {
                        echo "Build preparations"
                        withSonarQubeEnv('sonarqube') {
                            //sh "${scannerHome}/bin/sonar-scanner"
                            sh "/opt/sonarqube/sonar-scanner/bin/sonar-scanner"
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
//                           docker.image('jenkins/demo').push("$currentBuild.number")
//                    }
                    }
                }
            }

            }
    /**
            stage('Docker image pull')
            {
                steps
                {
                    script
                    {
                        sh("eval \$(aws ecr get-login --no-include-email | sed 's|https://||')")
                        docker.withRegistry(ECRURL, ECRCRED)
                        {
                            docker.image(PROJECT).pull()
                        }
                    }
                }
            }

      post
        {
            always
            {
                // Removing Docker image
                sh "docker rmi $IMAGE | true"
            }
        }
    **/
    }

