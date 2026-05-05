#######Create IAM User#############
resource "aws_iam_user" "user" {
  name = var.iam_user_name
}


#####Create IAM Policy (Full Admin Access)#########
resource "aws_iam_policy" "policy" {
  name        = var.policy_name
  description = "Full administrative access policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:ListBucket",
          "s3:GetObject",
          "logs:DescribeLogGroups",
          "logs:DescribeLogStreams",
          "logs:GetLogEvents"
        ]
        Resource = "*"
      }
    ]
  })
}

##########Attach Policy to User#############
resource "aws_iam_user_policy_attachment" "attach" {
  user       = aws_iam_user.user.name
  policy_arn = aws_iam_policy.policy.arn
}


########## Create IAM Group################
resource "aws_iam_group" "group" {
  name = var.group_name
}

###########Create IAM Policy (Full Admin Access)############
resource "aws_iam_policy" "gp_policy" {
  name        = var.gp_policy_name
  description = "Full administrative access policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = "*"
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}


########### Attach Policy to Group#############
resource "aws_iam_group_policy_attachment" "attach" {
  group      = aws_iam_group.group.name
  policy_arn = aws_iam_policy.gp_policy.arn
}

# Add User to Group
resource "aws_iam_user_group_membership" "membership" {
  user   = aws_iam_user.user.name
  groups = [aws_iam_group.group.name]
}

########Create IAM Role (trusted by Lambda)#########
resource "aws_iam_role" "custom_role" {
  name = var.role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

#######Create Custom Policy (Lambda, SQS, SNS permissions)############
resource "aws_iam_policy" "custom_policy" {
  name        = var.custom_policy_name
  description = "Custom policy for Lambda, SQS, and SNS access"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "sqs:SendMessage",
          "sqs:ReceiveMessage",
          "sqs:DeleteMessage",
          "sqs:GetQueueAttributes",
          "sns:Publish",
          "sns:Subscribe"
        ]
        Resource = "*"
      }
    ]
  })
}

#######Attach Policy to Role#############
resource "aws_iam_role_policy_attachment" "attach" {
  role       = aws_iam_role.custom_role.name
  policy_arn = aws_iam_policy.custom_policy.arn
}