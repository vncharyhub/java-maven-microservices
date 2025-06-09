resource "aws_iam_role" "jenkins" {
  name = "${var.cluster_name}-jenkins-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = { AWS = var.jenkins_ssh_iam_user_arn },
      Action = "sts:AssumeRole"
    }]
  })
}
