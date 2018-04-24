node {
    checkout scm

    stage('Init') {
        cleanWs()
    }
    stage('Get code') {
        git credentialsId: '94b9e957-0a7d-4b96-8d75-dd3a447b408a', url: 'git@github.com:ihassin/alexa-on-rails.git'
    }
    stage('Install dependencies') {
        sh 'gem install bundler'
        sh 'bundle install'
    }
    stage('Run tests') {
        sh "ALEXA_DB_PASSWORD=${ENV.ALEXA_DB_PASSWORD} ALEXA_DB_USERNAME=${ALEXA_DB_USERNAME} bundle exec rake"
    }
//    stage('Deploy') {
//        sh 'bundle exec cap production deploy'
//    }
}
