#!groovy

node {
  try {
    stage('Checkout') {
      checkout scm
    }

    stage('Build Image') {
      docker.image("registry.nspop.dk/tools/nspbuilder:${NSPBUILDERTAG}").inside() {
        sh "mvn clean install"
      }
    }
 
    stage ('Archive') {
    }

  } catch (err) {
    slackSend channel: 'trifork_ci', color: 'bad', message: "${env.JOB_NAME} ${env.BUILD_NUMBER} - Build failed ... (<${env.BUILD_URL}|Open>)", tokenCredentialId: 'Slack-Token'
    throw err
  } finally {
    stage ('Clean') {
      deleteDir()
    }
  }
}
