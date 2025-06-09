resource "aws_iam_role_policy" "jenkins" {
  role   = aws_iam_role.eks_node_role.name
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = "sts:AssumeRole",
        Resource = var.jenkins_ssh_iam_user_arn
      }
    ]
  })
}
