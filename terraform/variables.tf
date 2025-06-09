variable "cluster_name" {
  type        = string
  description = "EKS cluster name"
  default     = "microservices-cluster"
}
variable "aws_region" {
  type    = string
  default = "us-east-1"
}
