# Project Overview
## The Hello-World-EKS project is a comprehensive Terraform repository designed to create and manage AWS infrastructure with a focus on Elastic Kubernetes Service (EKS). This project showcases advanced Terraform skills, including the creation of VPCs, EKS clusters, API Gateways, and networking configurations.

### Features
EKS Cluster Setup: Utilizes Terraform modules to create and configure an EKS cluster. EKS Main Configuration
API Gateway Integration: Configures an API Gateway with security groups and VPC links for secure and scalable microservices. API Gateway Configuration
Networking Configuration: Establishes a robust networking setup including VPCs, subnets, and NAT gateways. Networking Main Configuration
Output Management: Efficiently manages and outputs critical infrastructure information. Outputs Configuration
Getting Started
Prerequisites: Ensure you have Terraform and AWS CLI installed and configured.
Clone the Repository: git clone https://github.com/arielrahamim/hello-world-eks.git
Initialize Terraform: Navigate to the cloned directory and run terraform init to initialize the project.
Apply Configuration: Execute terraform apply to create the infrastructure.
Project Structure
terraform/: Contains all Terraform configurations.
api-gateway/: Configurations for setting up AWS API Gateway.
eks/: Terraform scripts for EKS cluster setup.
networking/: Scripts for VPC and networking resources.
variables.tf: Defines variables used across the configurations.
outputs.tf: Manages output information from Terraform.
Customization
Modify terraform.tfvars to customize project names, regions, and other AWS-specific settings.
Adjust variables.tf in respective directories for fine-tuning resources like VPC CIDR blocks, EKS cluster settings, etc.
Contribution
Contributions are welcome! Please fork the repository and submit a pull request with your enhancements.

License
This project is distributed under the MIT License. See LICENSE for more information.
