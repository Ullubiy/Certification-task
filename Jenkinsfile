pipeline {

    agent any
    

    parameters {
        string(name: "username", description: "Username from docker hub")
        password(name: "password", description: "Password from docker hub")
    }

    stages {
        stage ('Preparing terraform') {
            steps {
               sh '''
                    cd terraform
                    cp .terraformrc ~/
                    terraform -version
               '''
            }
        }

        stage ('Provisioning for build instance') {
            steps {
                sh '''
                    cd terraform
                    terraform init
                    terraform plan 
                    terraform apply                    
                '''
            }
        }

        stage ('Adding host') {
            steps {
                sh '''
                    cd ../ansible
                    ansible-playbook common.yaml                                      
                '''
            }
        }

        stage ('Build project') {
            steps {
                sh '''
                    cd ansible
                    echo "username=$username\npassword=$password\n" > docker.properties
                    ansible-playbook build.yaml
                '''

        stage ('Deploy project') {
            steps {
                sh '''
                    cd ansible
                    ansible-playbook deploy.yaml
                '''
            }
        }

    }
}