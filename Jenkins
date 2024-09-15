pipeline {
    agent any
    environment {
        SONAR_HOME = tool "Sonar"
    }
    
    stages {
        stage("Code") {
            steps {
                echo "Cloning the code..."
                git url: "https://github.com/Sheheriyar99/crispy_credits.git", branch: "main"
                echo "Code Cloned Successfully"
            }
        }

        stage("SonarQube Analysis") {
            steps { 
                withSonarQubeEnv("Sonar") {
                   sh "${SONAR_HOME}/bin/sonar-scanner -Dsonar.projectName=crispycredits -Dsonar.projectKey=crispycredits -X"
               }   
           }
        }
        stage("OWASP Dependency Check") {
            steps {
                echo "Running OWASP Dependency Check..."
                dependencyCheck additionalArguments: '--scan ./', odcInstallation: 'OWASP'
                dependencyCheckPublisher pattern: '**/dependency-check-report.xml'
                echo "OWASP Analysis Completed Successfully"
            }
        }

        stage("Build & Test") {
            steps {
                echo "Building the Docker image..."
                sh 'docker build -t crispy_credits:latest .'
                echo "Docker build completed"
            }
        }

        stage("Trivy Scan") {
            steps {
                echo "Running Trivy security scan..."
                sh "trivy -d image crispy_credits"
                echo "Trivy scan completed"
            }
        }

        stage("Deploy") {
            steps {
                echo "Deploying the application..."
                sh "docker-compose -f docker-compose.yml up -d"
                echo "Deployment completed"
            }
        }
    }
}
