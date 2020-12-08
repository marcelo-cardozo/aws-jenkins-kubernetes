pipeline {

    agent any

    stages {

        stage('Deploy App') {
            steps {
                script {
                    ansiblePlaybook playbook: 'main.yaml', inventory: 'inventory'
                }
            }
        }
    }
}
