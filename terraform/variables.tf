variable "cluster_name"    { type=string, default="microservices-eks" }
variable "aws_region"      { type=string, default="us-east-1" }
variable "jenkins_ssh_iam_user_arn" { type=string, description="IAM User ARN allowed to assume role for kubectl access" }
