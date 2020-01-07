pipeline {

    agent any

    environment 
    {
        VERSION = 'latest'
        PROJECT = 'jenkinsdemo'
        IMAGE = 'jenkinsdemo:latest'
        ECRURL = 'http://562864705384.dkr.ecr.us-east-1.amazonaws.com'
        ECRCRED = 'ecr:eus-east-1:awskey'
    }

    stages {

        stage('Build preparations')
        {

            steps
            {
                script 
                {
                    // calculate GIT lastest commit short-hash
                    gitCommitHash = sh(returnStdout: true, script: 'git rev-parse HEAD').trim()
                    shortCommitHash = gitCommitHash.take(7)
                    // calculate a sample version tag
                    VERSION = shortCommitHash
                    // set the build display name
                    currentBuild.displayName = "#${BUILD_ID}-${VERSION}"
                    IMAGE = "$PROJECT:$VERSION"
                }
            }
        }

        stage('Docker build')
        {
            steps
            {
                script
                {
                    // Build the docker image using a Dockerfile
                    docker.build("562864705384.dkr.ecr.us-east-1.amazonaws.com/jenkinsdemo:latest")
                    //docker.build("$IMAGE","562864705384.dkr.ecr.us-east-1.amazonaws.com")
//                    docker.build('jenkins/demo')
        //sh "docker build --build-arg APP_NAME=receipts -t 534***385.dkr.ecr.us-east-2.amazonaws.com/bttrm-receipt-consumer:latest -f docker/prod/Dockerfile ."
                }
            }
        }

        stage('Docker push')
        {
            steps
            {
                script
                {


                    // login to ECR - for now it seems that that the ECR Jenkins plugin is not performing the login as expected. I hope it will in the future.
                    sh("eval \$(aws ecr get-login --no-include-email | sed 's|https://||')")
                    // Push the Docker image to ECR
                    docker.withRegistry(ECRURL, ECRCRED)
                    {
                        docker.image(IMAGE).push()
                    }

//                    docker.withRegistry('https://003656774475.dkr.ecr.us-east-1.amazonaws.com', 'ecr:us-east-1:karthik-aws') {
//                        docker.image('jenkins/demo').push("$currentBuild.number")
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
            // make sure that the Docker image is removed
            sh "docker rmi $IMAGE | true"
        }
    }
**/
}

