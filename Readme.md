# Flask App CI/CD Pipeline

## Overview

This project demonstrates a CI/CD pipeline for deploying a simple Flask web application using containerization and orchestration tools. The application features a single endpoint that returns "Hello, World!" and is deployed using Kubernetes with Minikube. The pipeline includes Docker containerization, deployment to a Kubernetes cluster, and basic testing to ensure the application is running correctly.

## Application Setup

### Prerequisites

- [Docker](https://docs.docker.com/get-docker/)
- [Minikube](https://minikube.sigs.k8s.io/docs/start/)
- [kubectl](https://kubernetes.io/docs/tasks/tools/)

### Project Structure

- `Dockerfile`: Dockerfile for building the Flask application container image.
- `k8s/`: Directory containing Kubernetes manifests for deployment and service.
  - `deployment.yaml`: Kubernetes Deployment configuration.
  - `service.yaml`: Kubernetes Service configuration.
- `.github/workflows/`: Directory containing GitHub Actions workflow for CI/CD.
  - `ci-cd.yaml`: GitHub Actions workflow file for building, pushing Docker images, and deploying to Kubernetes.

### Setup Instructions

1. **Clone the Repository:**
   ```bash
   git clone https://github.com/yourusername/flask-app.git
   cd flask-app
2. **Build and Run Locally (Optional):** To test the application locally before deploying, you can build and run the Docker container:
    ```bash
    docker build -t flask-hello-world .
    docker run -p 5000:5000 flask-hello-world
3. **Setup Minikube:**: Ensure Minikube is installed and running:
    ```bash
    minikube start --driver=docker
4. **Apply Kubernetes Manifests:**  Apply the Kubernetes manifests to deploy the application:
    ```bash
    kubectl apply -f k8s/deployment.yaml.local    
    kubectl apply -f k8s/service.yaml
5. **Verify Deployment:**: Get the URL of the deployed service:
    ```bash
    minikube service flask-app --url
6. **Run the CI/CD Pipeline**: The CI/CD pipeline is configured using GitHub Actions and will automatically run on pushes to the main branch or on pull requests.
## CI/CD Pipeline

The CI/CD pipeline for this project is configured using GitHub Actions and follows these steps:

1. **Checkout Code**
   - Retrieves the latest code from the repository.

2. **Set Up Minikube**
   - Installs and starts Minikube.

3. **Build, Tag, and Push Docker Image**
   - Builds the Docker image.
   - Tags the image with the commit hash.
   - Pushes the tagged image to my DockerHub repository.

4. **Apply Kubernetes Manifests**
   - Deploys the application to Kubernetes using environment variables.

5. **Wait for Deployment**
   - Waits for the Kubernetes deployment to complete.

6. **Get Service URL**
   - Retrieves the URL of the deployed service.

7. **Verify Flask App Output**
   - Checks if the application is reachable and running correctly.


## Best Practices Implemented
### Security

- **Secure Docker Hub Credentials**: Docker Hub password is managed using GitHub Secret `DOCKER_HUB_PASSWORD`.
- **Minimized Container Privileges**: Kubernetes configurations run the application with minimal privileges that why security context was added.

### High Availability

- **Multiple Replicas in Kubernetes**: Deployed the Flask application with at least 3 replicas to ensure high availability and `maxUnavailable` set to 2 to ensure 2 pods running. 
- **Rolling Updates**: Used Kubernetes rolling updates for zero-downtime deployments.

### Image Optimization

- **Optimized Dockerfile**: Designed the Dockerfile to be minimal, reducing image size and build times.
- **Tagging with Commit Hash**: Tagged Docker images with the commit hash for tracing and version association.


## Recommendations for Monitoring and Alerting

### Basic Monitoring

To monitor the application and the Kubernetes cluster, we can consider the following tools and practices:

- **Prometheus and Grafana**
  - **Prometheus** is an open-source monitoring system that collects metrics from configured targets at specified intervals. **Grafana** is used for visualizing these metrics.
  - Deploy Prometheus and Grafana in your Kubernetes cluster to gather and visualize metrics for both the application and cluster components.
  - **Prometheus** can be configured to scrape metrics from application endpoints and Kubernetes nodes.

### Alerting

To set up alerting for critical issues, such as application downtime or high resource usage, we can use:

- **Prometheus Alertmanager**
  - Alertmanager handles alerts sent by Prometheus and can send notifications via email, Slack, or other communication channels.
  - Define alert rules in Prometheus to monitor critical metrics (e.g., high CPU usage, memory usage, or application downtime).
  - Configure Alertmanager to send notifications based on these alerts.

- **Kubernetes Event Monitoring**
  - Use Kubernetes events to monitor for issues within the cluster. You can set up alerts based on events such as pod crashes or deployment failures.
  