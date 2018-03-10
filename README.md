# QuboleAccountSetup
Cross Cloud Qubole Account Setup via Terraform

I have been playing with Qubole in the last few weeks. Qubole is a multi-cloud big data platform. It helps you deploy your Big Data infrastructure on AWS, Azure and Oracle cloud. While I was trying to setup my AWS account to Qubole connectivity, I did spend quite a bit of time to get setup the IAM roles, security groups right. And could not proceed without some help from Qubole experts. So I went ahead and wrote Terraform scripts to automatically configure my AWS account. This script will configure the IAM roles, VPC, subents, route tables and bastion server. You can download the scripts from here and get started. 

For those new to Terraform, all configurations are specified in .tf files. The variable parameters can be specified in a terraform.tfvars file. In my scripts the terraform.tfvars can be used to specify the aws access_key, secret_key and region. Now, go ahead and give it a try. To run just download the scripts from this location to your setup, provide your aws access_key and secret_key and run the below.

#terraform apply

Now, why stop with just configuring for AWS. In the next phase I will extend this to configure the Qubole account across multiple cloud platforms. And also use finish the second step of the setup by configuring the Qubole account to jump-start you to run you AI workload.
