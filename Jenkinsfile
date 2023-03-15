pipeline{
    agent any
    stages{
        stage("Yum install Git")
            steps{
                script{
                    sh 'sudo yum install git -y'
                }
            }
        stage("Terraform Installation"){
            steps{
                script{
                    sh 'sudo yum install -y yum-utils'
                    sh  sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
                    sh  sudo yum -y install terraform
                }
                
            }
        }
        stage("TF Init"){
            steps{
                echo "Executing Terraform Init"
            }
        }
        stage("TF Validate"){
            steps{
                echo "Validating Terraform Code"
            }
        }
        stage("TF Plan"){
            steps{
                echo "Executing Terraform Plan"
            }
        }
        stage("TF Apply"){
            steps{
                echo "Executing Terraform Apply"
            }
        }
        stage("Invoke Lambda"){
            steps{
                echo "Invoking your AWS Lambda"
            }
        }
    }
}
